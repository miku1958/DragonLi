//
//  DownloadManager.swift
//  DragonLi
//
//  Created by mikun on 2018/3/22.
//  Copyright © 2018年 mikun. All rights reserved.
//

import UIKit

public class ConnectManager {

	public var taskDic = [String:[URLSessionTask]]()


	public func createPostTask(urlUnit:URLUnit, uploadFiles:[uploadItemUnit] = [],option:DragonLiOptionsInfo,  finish:ConnectFinish? = nil) -> () {

		var request = URLRequest.init(url: URL(string: urlUnit.host)!)
		request.httpMethod = "POST"
		
		if uploadFiles.count > 0 {
			createUploadFilleTask(urlUnit:urlUnit, request: request, option:option, uploadFiles: uploadFiles, finish: finish)
		}else{
			request.httpBody = urlUnit.paraStr.data(using: .utf8);
			createDataTask(urlUnit:urlUnit, request: request, option:option, finish: finish)
		}
	}


	public func createGetTask(urlUnit:URLUnit, option:DragonLiOptionsInfo, finish:ConnectFinish? = nil) -> () {
		var request = URLRequest.init(url: URL(string: urlUnit.fullUrl)!)
		request.httpMethod = "GET"

		createDataTask(urlUnit:urlUnit, request: request, option:option, finish: finish)
	}


	func  createDataTask(urlUnit:URLUnit,request:URLRequest,option:DragonLiOptionsInfo, finish:ConnectFinish? = nil) -> () {
		var task:URLSessionTask!
		var config:URLSessionConfiguration!
		let url = urlUnit.fullUrl
		if option.taskiInSecret() {
			config = URLSessionConfiguration.ephemeral
		}else if option.taskInBackground(){
			config  = URLSessionConfiguration.background(withIdentifier: request.url?.host ?? "")
		}
		if config != nil{
			task = URLSession.shared.dataTask(with: request) {
				(data, urlResponse, error) in
				self.convertResult(data, url, error, option, finish)
			}
		}else{
			task = URLSession.shared.dataTask(with: request) {
				(data, urlResponse, error) in
				self.convertResult(data, url, error, option, finish)
			}
		}
		if option.autoCancelSameRequests(){
			update(url:url , task: task)
		}
		task.resume()
	}
	func  createUploadFilleTask(urlUnit:URLUnit, request:URLRequest,option:DragonLiOptionsInfo, uploadFiles:[uploadItemUnit], finish:ConnectFinish? = nil) -> () {

		var request = request
		let url = urlUnit.fullUrl

		let BOUNDRY = "Boundary+\(arc4random())\(arc4random())"

		request.setValue("multipart/form-data; boundary=\(BOUNDRY)", forHTTPHeaderField: "Content-Type")

		let data = createDataFrom(para:urlUnit.paraDic,uploadFiles: uploadFiles, BOUNDRY:BOUNDRY)

		request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")

		request.httpBody = data

		let task = URLSession.shared.uploadTask(with: request, from: data){
			(data, urlResponse, error) in
			self.convertResult(data, url, error, option, finish)
		}
		if option.autoCancelSameRequests(){
			update(url:url , task: task)
		}
		task.resume()

	}

	func convertResult(_ data:Data?, _ fullURL:String?, _ error:Error?, _ option:DragonLiOptionsInfo, _ finish:ConnectFinish?) {
		if option.autoCancelSameRequests(){
			if  let fullURL = fullURL,let tasks = taskDic[fullURL] {
				DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(0)) {
					for task in tasks {
						task.cancel()//某些上传的业务来到这里可能会停了
					}
					self.taskDic.removeValue(forKey: fullURL)
				}
			}
		}

		if option.convertJsonObject(){
			do{
				let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: [])
				if option.debugPrintUrl() { print(json) }
				DispatchQueue.main.async {
					finish?(.success(json,false))
				}
			}catch{
				DispatchQueue.main.async {
					finish?(.success(data,false))
				}
			}
		}else{
			if error != nil{
				DispatchQueue.main.async {
					finish?(.failure(error!))
				}
			}else{
				DispatchQueue.main.async {
					finish?(.success(data,false))
				}
			}
		}
	}
	func createDataFrom(para:[String:Any],uploadFiles:[uploadItemUnit], BOUNDRY:String) -> Data {

		let Newline = "\r\n"
		let boundary = "--\(BOUNDRY)\(Newline)"
		var data = Data()

		var dataStr = ""
		for (key,value) in para{
			dataStr += "\(boundary)Content-Disposition: form-data; name=\"\(key)\"\(Newline)\(Newline)\(value)\(Newline)"
		}
		print(dataStr)
		if let appendData = dataStr.data(using: .utf8)
		{
			data.append(appendData)
		}

		for uploadItem in uploadFiles {
			//拼接第一个--boundry
			var appendStr = boundary

			//第一个参数的描述部分
			appendStr += "Content-Disposition: form-data; name=\"\(uploadItem.paraName)\"; filename=\"\(uploadItem.fileName)\"\(Newline)"

			//指定第一个参数的类型,不然服务器不认识,注意后边多了一个换行
			appendStr += "Content-Type: \(uploadItem.mimeType)\(Newline)\(Newline)"

			if let appendData = appendStr.data(using: .utf8) {
				data.append(appendData)
			}
			print(appendStr)
			//拼接上传的数据
			data.append(uploadItem.data)
			if let appendData = "\(Newline)".data(using: .utf8) {
				data.append(appendData)
			}
		}

		//后边的结尾
		if let appendData = "--\(BOUNDRY)--\(Newline)".data(using: .utf8) {
			data.append(appendData)
		}

		return data
	}

	func update(url:String,task:URLSessionTask) {

		DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(0)) {
			if  self.taskDic[url] == nil {
				self.taskDic[url] = []
			}
			self.taskDic[url]!.append(task)
		}

	}
}

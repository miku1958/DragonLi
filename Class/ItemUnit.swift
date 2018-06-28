//
//  uploadItem.swift
//  DragonLi
//
//  Created by mikun on 2018/3/22.
//  Copyright © 2018年 mikun. All rights reserved.
//

import UIKit

public struct URLUnit{
	let host:String
	let paraStr:String
	let paraDic:[String:Any]
	let fullUrl:String
	

	init(host testHost:String, para:Dictionary<String, Any>) {
		var para = para
		var urlCmp = URLComponents.init(string: testHost)

		for item in (urlCmp?.queryItems  ?? []).enumerated(){
			guard
				let value = item.element.value
				else {continue}
			para[item.element.name] = value
		}

		paraDic = para

		var queryArr:[URLQueryItem] = [];
		let allKeys = para.keys.sorted()
		for strKey in allKeys {
			let value = "\(para[strKey] ?? "")"
			queryArr.append(URLQueryItem(name: strKey, value: value))
		}
		urlCmp?.queryItems = queryArr
		guard
			let url = urlCmp?.url?.absoluteString,
			let query = urlCmp?.query
		else {
			host = testHost
			paraStr = ""
			fullUrl = testHost
			return
		}

		var basehost = url
		if let range = basehost.range(of: "?\(query)") {
			basehost.replaceSubrange(range, with: "")
		}
		if
			let queryPercent = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			let range = basehost.range(of: "?\(queryPercent)"){
			
			basehost.replaceSubrange(range, with: "")
		}


		host = basehost
		fullUrl = url
		paraStr = query
	}

}

open class uploadItemUnit:NSObject {
	let data:Data;
	let paraName:String;
	let fileName:String;
	let mimeType:String;

	@objc public init(data:Data,paraName:String?,fileName:String?,mimeType:String?) {

		self.data = data
		self.paraName = paraName ?? ""

		if fileName != nil && (fileName?.count ?? 0) > 0 {
			self.fileName = fileName!
		}else{
			self.fileName = "file";
		}

		if mimeType != nil && (mimeType?.count ?? 0) > 0 {
			self.mimeType = mimeType!
		}else{
			self.mimeType = "application/octet-stream";
		}

	}
}

public enum DragonLiResult {
	case success(Any?,Bool)//(data,isCache)
	case failure(Error)//(data,isCache)
}

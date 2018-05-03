//
//  DragonLi.swift
//  DragonLi
//
//  Created by mikun on 2018/3/19.
//  Copyright © 2018年 mikun. All rights reserved.
//

import UIKit


public typealias ConnectFinish =  ((_ result:DragonLiResult) -> Void)

class DragonLi{
	fileprivate var defaultHost:String = ""

	fileprivate lazy var httpRequestListCache:[String:TimeInterval] = [:]

	public var defaultOptions = DragonLiEmptyOptionsInfo
	public static let shared:DragonLi = DragonLi()

	let connectMgr = ConnectManager()

	public static func setDefault(host:String? = nil, option:DragonLiOptionsInfo? = nil){
		if let host = host{
			shared.defaultHost = host
		}
		if let option = option{
			shared.defaultOptions += option
		}

	}
	public static func cancel(_ url:String){
		if let tasks = shared.connectMgr.taskDic[url] {
			for task in tasks{
				task.cancel()
			}
			shared.connectMgr.taskDic.removeValue(forKey: url)
		}
	}
	public static func cancelAll(){
		for tasks in shared.connectMgr.taskDic.values {
			for task in tasks{
				task.cancel()
			}
		}
		shared.connectMgr.taskDic.removeAll()
	}

}

extension DragonLi{
	public static func add(_ url:DragonLiUrlPath, para:Dictionary<String, Any>? = nil,uploadUnits:[uploadItemUnit] = [], option:DragonLiOptionsInfo? = nil, finish:ConnectFinish? = nil) -> Void {

		let options = self.shared.defaultOptions + (option ?? DragonLiEmptyOptionsInfo)
		var url = url as! String
		if self.shared.defaultHost.last == "/" && url.first == "/" {
			url.removeFirst()
		}
		if self.shared.defaultHost.count>0 && self.shared.defaultHost.last != "/" && url.first != "/" {
			url = "/\(url)"
		}
		if url.last == "?" {
			url.removeLast()
		}
		url = self.shared.defaultHost  + url


		let urlUnit = URLUnit(host: url, para: (para ?? Dictionary()))

		let cacheKey = urlUnit.fullUrl

		if options.debugPrintUrl() { print(cacheKey) }

		if options.enableCache() {
			if finish != nil {
				if let cacheData = CacheManager.get(cacheName: cacheKey){
					finish!(.success(cacheData,true))
					if options.cacheOnly() { return; }
				}
			}
		}
		if options.filterMultipleRequests() {
			let requestTime = Date().timeIntervalSince1970;
			if let lastTime = shared.httpRequestListCache[cacheKey] {
				//				if lastTime - requestTime <{
				//
				//				}
				return;
			}
			shared.httpRequestListCache[cacheKey] = requestTime;
		}

		let handleFinish:ConnectFinish = { (result) in
			if options.filterMultipleRequests() {
				shared.httpRequestListCache.removeValue(forKey: cacheKey);
			}
			finish?(result)
		}
		for method in options.reversed(){
			switch method {
			case .methodIsGET:
				shared.connectMgr.createGetTask(urlUnit:urlUnit,option:options, finish: handleFinish)
				return;
			case .methodIsPOST:
				shared.connectMgr.createPostTask(urlUnit:urlUnit,uploadFiles: uploadUnits,option:options, finish: handleFinish)
				return;
			default:break;
			}
		}

	}
}

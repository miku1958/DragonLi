//
//  DragonLi.swift
//  DragonLi
//
//  Created by mikun on 2018/3/19.
//  Copyright © 2018年 mikun. All rights reserved.
//

import UIKit


public typealias ConnectFinish =  ((_ result:DragonLiResult) -> Void)

public class DragonLi{
	private var defaultHost:String?

	public var defaultOptions = DragonLiEmptyOptionsInfo
	public static let shared:DragonLi = DragonLi()

	let connectMgr = ConnectManager()

	static func setDefault(host:String? = nil, option:DragonLiOptionsInfo? = nil){
		if let option = option{
			shared.defaultOptions += option
		}

	}

	static func add(_ url:DragonLiUrlPath, para:Dictionary<String, Any>? = nil,uploadUnits:[uploadItemUnit] = [], option:DragonLiOptionsInfo? = nil, finish:ConnectFinish? = nil) -> Void {

		let options = self.shared.defaultOptions + (option ?? DragonLiEmptyOptionsInfo)


		let url = (self.shared.defaultHost ?? "")  + (url as! String);


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
//			httpRequestListCache[cacheKey] = @(requestTime);
		}

		for method in options.reversed(){
			switch method {
			case .methodIsGET:
				shared.connectMgr.createGetTask(urlUnit:urlUnit,option:options, finish: finish)
				return;
			case .methodIsPOST:
				shared.connectMgr.createPostTask(urlUnit:urlUnit,uploadFiles: uploadUnits,option:options, finish: finish)
				return;
			default:break;
			}
		}

	}


}

extension DragonLi{

}

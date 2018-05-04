//
//  DragonLiOCInterface.swift
//  HireAssistant
//
//  Created by mikun on 2018/4/3.
//  Copyright © 2018年 sunshine. All rights reserved.
//

import UIKit


open  class DragonLiOC: NSObject {
	static func convertOption(_ optionInfo:DragonLiOptionsInfoOCItem) -> (DragonLiOptionsInfo){
		let option =  optionInfo.rawValue
		var options:DragonLiOptionsInfo = []
		if (option & 1<<01) > 0 { options.append(.methodIsGET) }
		if (option & 1<<02) > 0 { options.append(.methodIsPOST) }

		if (option & 1<<10) > 0 { options.append(.convertJsonObject) }

		if (option & 1<<20) > 0 { options.append(.debugPrintUrl) }
		if (option & 1<<21) > 0 { options.append(.debugPrintResponseData) }

		if (option & 1<<30) > 0 { options.append(.enableCache) }
		if (option & 1<<31) > 0 { options.append(.cacheOnly) }

		if (option & 1<<40) > 0 { options.append(.taskiInSecret) }
		if (option & 1<<41) > 0 { options.append(.taskInBackground) }

		if (option & 1<<50) > 0 { options.append(.filterMultipleRequests) }
		return options;
	}
	@objc open static func setDefault(host:String, option:DragonLiOptionsInfoOCItem){
		DragonLi.setDefault(host: host, option: convertOption(option))
	}
	@objc open static func cancel(_ url:String){
		DragonLi.cancel(url)
	}
	@objc open static func cancelAll(){
		DragonLi.cancelAll()
	}
	@objc open static func add(_ url:String, para:Dictionary<String, Any>? = nil,uploadUnits:[uploadItemUnit] = [], option:DragonLiOptionsInfoOCItem, finish:((_ error:Error?,_ data:Any?,_ isCache:Bool) -> Void)?) -> Void {

		DragonLi.add(url, para: para, uploadUnits: uploadUnits, option: convertOption(option)) { (result) in
			switch result {
			case let .success(data, isCache):
				finish?(nil,data,isCache)
			case let .failure(error):
				finish?(error,nil,false)
			}
		}
	}
}

//
//  DragonLi.swift
//  DragonLi
//
//  Created by mikun on 2018/3/19.
//  Copyright © 2018年 mikun. All rights reserved.
//

import Foundation

typealias Success =  ((_ data:Any, _ isCache:Bool) -> Void)
typealias Failure = ((_ error:Error) -> Void)

public final class DragonLi{
	private var defaultHost:String?
	private var defaultOption = DragonLiEmptyOptionsInfo
	public static let shared:DragonLi = DragonLi()


}

extension DragonLi{
	static func setDefault(host:String? = nil, option:DragonLiOptionsInfo? = nil){

	}

	static func add(url:UrlPathDelegate, para:Dictionary<String, Any>? = nil, option:DragonLiOptionsInfo? = nil, success:Success? = nil, failure:Failure? = nil) -> Void {
		let option = self.shared.defaultOption + ( option ?? DragonLiEmptyOptionsInfo)

	}
}

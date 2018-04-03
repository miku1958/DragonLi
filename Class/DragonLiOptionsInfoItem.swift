//
//  Option.swift
//  DragonLi
//
//  Created by mikun on 2018/3/19.
//  Copyright © 2018年 mikun. All rights reserved.
//

import UIKit


public typealias DragonLiOptionsInfo = [DragonLiOptionsInfoItem]

let DragonLiEmptyOptionsInfo = DragonLiOptionsInfo()



public protocol AutoCreateEnum{ }

public enum DragonLiOptionsInfoItem:AutoCreateEnum{

	case methodIsGET
	case methodIsPOST

	case convertJsonObject

	case debugPrintUrl
	case debugPrintResponseData
	case enableCache
	case independentTask
	case cacheOnly
	case filterMultipleRequests
}





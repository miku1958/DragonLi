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

	case methodIsGET//check
	case methodIsPOST//check

	case convertJsonObject//check

	case debugPrintUrl//check
	case debugPrintResponseData//check

	case enableCache
	case cacheOnly

///use an independent URLSession instand of URLSession.shared
	case taskiInSecret//check
	case taskInBackground//check

///only allow one task for same requestURL
	case filterMultipleRequests//check
///if allow, when finish a request,the other same url request will be cancel
	case autoCancelSameRequests//check
}





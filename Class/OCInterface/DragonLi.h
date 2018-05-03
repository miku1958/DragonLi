//
//  DragonLi.h
//  HireAssistant
//
//  Created by mikun on 2018/4/4.
//  Copyright © 2018年 sunshine. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, DragonLiOptionsInfoOCItem) {
	DragonLiOptionsInfoItemMethodIsGET = 1<<01,
	DragonLiOptionsInfoItemMethodIsPOST = 1<<02,

	DragonLiOptionsInfoItemConvertJsonObject = 1<<10,

	DragonLiOptionsInfoItemDebugPrintUrl = 1<<20,
	DragonLiOptionsInfoItemDebugPrintResponseData = 1<<21,

	DragonLiOptionsInfoItemEnableCache = 1<<30,
	DragonLiOptionsInfoItemCacheOnly = 1<<31,

	DragonLiOptionsInfoItemTaskiInSecret = 1<<40,
	DragonLiOptionsInfoItemTaskInBackground = 1<<41,

	DragonLiOptionsInfoItemFilterMultipleRequests = 1<<50,
};



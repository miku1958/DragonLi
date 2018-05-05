// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


public func == (lhs: DragonLiOptionsInfoItem, rhs: DragonLiOptionsInfoItem) -> Bool {
	switch (lhs, rhs) {
	case (.methodIsGET, .methodIsGET): return true
	case (.methodIsPOST, .methodIsPOST): return true
	case (.convertJsonObject, .convertJsonObject): return true
	case (.debugPrintUrl, .debugPrintUrl): return true
	case (.debugPrintResponseData, .debugPrintResponseData): return true
	case (.enableCache, .enableCache): return true
	case (.cacheOnly, .cacheOnly): return true
	case (.taskiInSecret, .taskiInSecret): return true
	case (.taskInBackground, .taskInBackground): return true
	case (.filterMultipleRequests, .filterMultipleRequests): return true
	case (.autoCancelSameRequests, .autoCancelSameRequests): return true
	default: return false
	}
}

extension Collection where Iterator.Element == DragonLiOptionsInfoItem {


	func methodIsGET() -> Bool {
		return contains { $0 ==  .methodIsGET}
	}


	func methodIsPOST() -> Bool {
		return contains { $0 ==  .methodIsPOST}
	}


	func convertJsonObject() -> Bool {
		return contains { $0 ==  .convertJsonObject}
	}


	func debugPrintUrl() -> Bool {
		return contains { $0 ==  .debugPrintUrl}
	}


	func debugPrintResponseData() -> Bool {
		return contains { $0 ==  .debugPrintResponseData}
	}


	func enableCache() -> Bool {
		return contains { $0 ==  .enableCache}
	}


	func cacheOnly() -> Bool {
		return contains { $0 ==  .cacheOnly}
	}


	func taskiInSecret() -> Bool {
		return contains { $0 ==  .taskiInSecret}
	}


	func taskInBackground() -> Bool {
		return contains { $0 ==  .taskInBackground}
	}


	func filterMultipleRequests() -> Bool {
		return contains { $0 ==  .filterMultipleRequests}
	}


	func autoCancelSameRequests() -> Bool {
		return contains { $0 ==  .autoCancelSameRequests}
	}


}


//
//  ViewController.swift
//  DragonLi
//
//  Created by mikun on 2018/3/19.
//  Copyright © 2018年 mikun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var dataArr = [Data]()
	override func viewDidLoad() {
		super.viewDidLoad()


		DragonLi.setDefault(host: nil, option: [.convertJsonObject,.debugPrintUrl])

	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let picker = UIImagePickerController()
		picker.delegate = self
		present(picker, animated: true, completion: nil)

	}

	@IBAction func release(_ sender: Any) {
		let para = [
			"Content":"Creshiceshi",
			"Tags":"",
			"city":"Shantou",
			"device":"5",
			"dist":"Longhu",
			"lat":"23.368768",
			"lng":"116.7172303918",
			"locShare":"1",
			"token":"3a7ddfd0bc8e712221ec",
			"v":"8.1",
			]

		DragonLi.add(urls.isCompleteInfo,para:para, option: [.methodIsPOST]) {
			(result) in
			switch result{
			case let .success(data, isCache):
				print(data ?? "data is nil")
				print(isCache)

			case let .failure(error):
				print(error)
			}
		}
	}
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

		let image = info[UIImagePickerControllerOriginalImage] as! UIImage

		guard let imageData = UIImageJPEGRepresentation(image, 0) else { return }

		dataArr.append(imageData)
	}
}


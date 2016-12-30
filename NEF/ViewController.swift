//
//  ViewController.swift
//  NEF
//
//  Created by include tech. on 12/12/16.
//  Copyright © 2016 include tech. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, tapDelegate {
	
	
	
	//MARK:- Structs
	struct ScreenSize {
		static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
		static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
		static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
		static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
	}
	
	struct DeviceType {
		static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
		static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
		static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
		static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
	}

	// MARK:- View
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.navigationController?.navigationBar.topItem?.title = "NEF"
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.navigationBar.clipsToBounds = true
		
		let container = Container()
		container.delegate = self
		self.view.addSubview(container)
		container.snp.makeConstraints { (make) in
			make.top.left.right.bottom.equalTo(view)
		}
		
		let topContainerView = UIImageView()
		topContainerView.image = UIImage(named: "3.png")
		topContainerView.contentMode = .scaleAspectFill
		topContainerView.tag = 1
//		topContainerView.userInteractionEnabled = true
		container.addSubview(topContainerView)
		topContainerView.snp.makeConstraints { (make) -> Void in
			make.width.equalTo(view)
			make.height.equalTo(view).multipliedBy(0.40)
			make.top.equalTo(view).offset(20)
		}
		
		let topLeftView = VC()
		topLeftView.imgView.image = UIImage(named: "4.jpg")
		topLeftView.tag = 2
//		topLeftView.userInteractionEnabled = true
		container.addSubview(topLeftView)
		topLeftView.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(view)
			make.width.equalTo(view.snp.width).multipliedBy(0.50)
			make.height.equalTo(DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 ? 130: 150)
			make.top.equalTo(topContainerView.snp.bottom).offset(1)
		}
		
		let topRightView = VC()
		topRightView.imgView.image = UIImage(named: "5.jpg")
		topRightView.tag = 3
//		topRightView.userInteractionEnabled = true
		container.addSubview(topRightView)

		topRightView.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(topLeftView.snp.right).offset(1)
			make.width.equalTo(view.snp.width).multipliedBy(0.50)
			make.height.equalTo(DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 ? 130: 150)
			make.top.equalTo(topContainerView.snp.bottom).offset(1)
		}
		
		let middleLeftView = VC()
		middleLeftView.tag = 4
		middleLeftView.imgView.image = UIImage(named: "6.jpg")
//		middleLeftView.userInteractionEnabled = true
		container.addSubview(middleLeftView)

		middleLeftView.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(view)
			make.height.equalTo(topLeftView.snp.height)
			make.width.equalTo(view.snp.width).multipliedBy(0.50)
			make.top.equalTo(topLeftView.snp.bottom).offset(1)
		}
		
		let middleRightView = VC()
		middleRightView.imgView.image = UIImage(named: "7.jpg")
		middleRightView.tag = 5
//		middleRightView.userInteractionEnabled = true
		container.addSubview(middleRightView)

		middleRightView.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(middleLeftView.snp.right).offset(1)
			make.height.equalTo(topLeftView.snp.height)
			make.width.equalTo(view.snp.width).multipliedBy(0.50)
			make.top.equalTo(topRightView.snp.bottom).offset(1)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK:- Container Delegate Method
	func setDelegate(_ tag: Int) {
		print(tag)
//		self.performSegueWithIdentifier("pushVCSegue", sender: nil)
		if tag % 2 == 0 {
			if let tapped = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
				self.navigationController?.pushViewController(tapped, animated: true)
			}
		} else {
			if let tapped = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rankingTableViewController") as? rankingTableViewController {
				self.navigationController?.pushViewController(tapped, animated: true)
			}
		}
	}
	
}
// MARK:- UIColor extension
extension UIColor {
	convenience init(hex: Int) {
		let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
		let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
		let blue = CGFloat(hex & 0xFF) / 255.0
		self.init(red: red, green: green, blue: blue, alpha: 1.0)
	}
}


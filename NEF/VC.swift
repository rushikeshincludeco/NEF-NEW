//
//  VC.swift
//  NEF
//
//  Created by include tech. on 16/12/16.
//  Copyright © 2016 include tech. All rights reserved.
//

import UIKit
import SnapKit

class VC: UIView {
	let imgView = UIImageView()

	override init (frame : CGRect) {
		super.init(frame : frame)
		// Do what you want.
		
		let topBar = UIView()
		topBar.backgroundColor = UIColor(hex: 0xEDAD41)
		topBar.isUserInteractionEnabled = false
		self.addSubview(topBar)
		
		
		topBar.snp.makeConstraints{ (make) -> Void in
			make.left.right.equalTo(self)
			make.height.equalTo(10)
			make.top.equalTo(self)
		}
//		imgView.contentMode = .ScaleToFill
		imgView.isUserInteractionEnabled = false
		self.addSubview(imgView)
		imgView.snp.makeConstraints{ (make) -> Void in
			make.left.right.equalTo(self)
			make.top.equalTo(topBar.snp.bottom)
			make.height.equalTo(self).multipliedBy(0.90)
		}
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	

}

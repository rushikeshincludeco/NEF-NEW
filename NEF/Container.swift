//
//  Container.swift
//  NEF
//
//  Created by include tech. on 15/12/16.
//  Copyright © 2016 include tech. All rights reserved.
//

import UIKit

//MARK:- Delegate
@objc public protocol tapDelegate:  NSObjectProtocol {
	
	func setDelegate(_ tag: Int)
}

class Container : UIView {
	
	var delegate : tapDelegate?
	
	//MARK:- Helper Methods
	
	func expandView(_ sender: UIView, completion:@escaping ((Bool) -> Void)) -> Void {
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			
			sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
			self.bringSubview(toFront: sender)
			sender.layer.masksToBounds = false
			completion(true)
		})
	}
	
	func collapseView(_ sender: UIView, completion:@escaping ((Bool) -> Void)) -> Void {
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			
			sender.transform = CGAffineTransform(scaleX: 1, y: 1)
			sender.layer.masksToBounds = false
			completion(true)
		})
	}	
	
	//MARK:- Touch related method
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			if let sender = touch.view {
				self.expandView(sender, completion: { _ in [] } )
			}
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			if touch.view != nil {
				let point = touch.location(in: self)
				var activeView : UIView?
				for view in subviews {
					self.collapseView(view, completion: { _ in [] })
					if view.frame.contains(CGRect(x: point.x - 15, y: point.y - 15, width: 30, height: 30)) {
						activeView = view
					}
				}
				
				if let actView = activeView {
					self.expandView(actView, completion: { _ in [] })
				}
			}
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let point = touch.location(in: self)
			var lastView : UIView?
			for view in subviews {
				self.collapseView(view, completion: { _ in [] })
				if view.frame.contains(CGRect(x: point.x - 15, y: point.y - 15, width: 30, height: 30)) {
					lastView = view
				}
			}
			
			if let del = delegate,
			 let lastView = lastView {
				del.setDelegate(lastView.tag)

			}

			if touch.view != nil {
				for view in subviews {
					self.collapseView(view, completion: { _ in [] } )
				}
			}
		}
	}
}

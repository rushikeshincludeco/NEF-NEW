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
	
	func setDelegate(tag: Int)
}

class Container : UIView {
	
	var delegate : tapDelegate?
	
	//MARK:- Helper Methods
	
	func expandView(sender: UIView, completion:((Bool) -> Void)) -> Void {
		UIView.animateWithDuration(0.2, animations: { () -> Void in
			
			sender.transform = CGAffineTransformMakeScale(1.1, 1.1)
			self.bringSubviewToFront(sender)
			sender.layer.masksToBounds = false
			completion(true)
		})
	}
	
	func collapseView(sender: UIView, completion:((Bool) -> Void)) -> Void {
		UIView.animateWithDuration(0.2, animations: { () -> Void in
			
			sender.transform = CGAffineTransformMakeScale(1, 1)
			sender.layer.masksToBounds = false
			completion(true)
		})
	}	
	
	//MARK:- Touch related method
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if let touch = touches.first {
			if let sender = touch.view {
				self.expandView(sender, completion: { _ in [] } )
			}
		}
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if let touch = touches.first {
			if touch.view != nil {
				let point = touch.locationInView(self)
				var activeView : UIView?
				for view in subviews {
					self.collapseView(view, completion: { _ in [] })
					if view.frame.contains(CGRectMake(point.x - 15, point.y - 15, 30, 30)) {
						activeView = view
					}
				}
				
				if let actView = activeView {
					self.expandView(actView, completion: { _ in [] })
				}
			}
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if let touch = touches.first {
			let point = touch.locationInView(self)
			var lastView : UIView?
			for view in subviews {
				self.collapseView(view, completion: { _ in [] })
				if view.frame.contains(CGRectMake(point.x - 15, point.y - 15, 30, 30)) {
					lastView = view
				}
			}
			
			if let del = delegate,
			 lastView = lastView {
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

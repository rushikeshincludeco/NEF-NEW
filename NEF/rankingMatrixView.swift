//
//  rankingTableViewCell.swift
//  NEF
//
//  Created by include tech. on 28/12/16.
//  Copyright © 2016 include tech. All rights reserved.
//

import UIKit
import SnapKit

class rankingMatrixView : UIView {
	var columnWidths: Array<Int>
	var numRows:Int=0
	var dy:Int=0
	
	init(frame:CGRect, columns:Array<Int>) {
		columnWidths = columns
		super.init(frame: frame);
		return;
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addRecord(record:Array<String>){
		assert(columnWidths.count == record.count)
		
		let rowHeight:Int = 30
		var dx:Int = 0
		
		
		for i in 0..<record.count {
			let colWidth:Int = self.columnWidths[i]
			let cellRect:CGRect = CGRect.init(x: dx, y: self.dy, width: colWidth, height: rowHeight)
			
			dx += colWidth - 1
			
			let column:UILabel = UILabel.init(frame: cellRect)
			column.layer.borderColor = UIColor.darkGray.cgColor
			column.layer.borderWidth = 1.0
			column.numberOfLines = 0
			column.textAlignment = .center
			column.font = UIFont.init(name: "Helvetica", size: 12.0)
			
			column.text = record[i]
			self.addSubview(column)
		}
		
		self.numRows += 1
		self.dy += rowHeight - 1
		
		
		return;
	}
}

//
//  rankingTableViewController.swift
//  NEF
//
//  Created by include tech. on 28/12/16.
//  Copyright © 2016 include tech. All rights reserved.
//

import UIKit

class rankingTableViewController: UIViewController{

	var labelsMatrixView   : rankingMatrixView!;

    override func viewDidLoad() {
        super.viewDidLoad()
		self.labelsMatrixView = rankingMatrixView(frame: CGRect.init(x: 5, y: 60, width: 310, height: 100), columns: [60, 125, 125])
		self.view.addSubview(self.labelsMatrixView)
		labelsMatrixView.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(70)
			make.left.equalTo(view).offset(30)
			make.right.bottom.equalTo(view)
		}
		
		labelsMatrixView.addRecord(record: ["S.no.", "Item", "Value"])
		labelsMatrixView.addRecord(record: ["1", "Item1", "Value1"])
		labelsMatrixView.addRecord(record: ["2", "Item2", "Value2"])
		labelsMatrixView.addRecord(record: ["Some Date", "06/24/2013", "06/30/2013"])
		labelsMatrixView.addRecord(record: ["Field1", "hello", "This is a really really long string and should wrap to multiple lines."])
		labelsMatrixView.addRecord(record: ["Long Fields", "The quick brown fox jumps over the little lazy dog.", "some new value"])
		

		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
}

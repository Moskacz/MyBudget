//
//  DailySpendingTableViewCell.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import UIKit

class DailySpendingTableViewCell: UITableViewCell {
	
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var value: UILabel!
	@IBOutlet weak var icon: UIImageView!
	
	func setValue(value: NSNumber) {
		self.value.text = value.stringValue
		self.backgroundColor = value.floatValue > 0 ? Constants.Colors.CellGreenColor : Constants.Colors.CellRedColor
	}	
	
}

//
//  DateFormatter.swift
//  MyBudget
//
//  Created by Michal Moskala on 03/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import UIKit

class DateFormatter: NSDateFormatter {
	
	override init() {
		super.init()
		self.dateFormat = "dd/MM/yyyy"
		self.timeZone = NSTimeZone(name: "GMT")
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func shortStringFromDate(date: NSDate) -> String {
		self.dateFormat = "dd/MM/yyyy"
		return self.stringFromDate(date)
	}
	
	func fullLengthStringFromDate(date: NSDate) -> String {
		self.dateFormat = "dd/MM/yyyy\nhh:mm:ss"
		return self.stringFromDate(date)
	}	
	
}

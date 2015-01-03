//
//  SpendingDTO.swift
//  MyBudget
//
//  Created by Michal Moskala on 20/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import Foundation

class SpendingDTO {
	let date: NSDate
	let value: NSNumber
	
	var stringDateDescription: String {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		return dateFormatter.stringFromDate(self.date)
	}
	
	init(date: NSDate, value: NSNumber) {
		self.date = date
		self.value = value
	}
}
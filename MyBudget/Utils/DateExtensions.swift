//
//  DateExtensions.swift
//  MyBudget
//
//  Created by Michal Moskala on 04/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import Foundation

extension NSDate {
	
	class func isDateToday(dateLiteral: String) -> Bool {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		return dateLiteral == dateFormatter.stringFromDate(NSDate())
	}
	
}
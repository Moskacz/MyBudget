//
//  DailySpending.swift
//  MyBudget
//
//  Created by Michal Moskala on 03/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import Foundation

class DailySpending {
	let dateLiteral: String
	let value: NSNumber
	
	init(dateLiteral: String, value: NSNumber) {
		self.dateLiteral = dateLiteral
		self.value = value
	}
}
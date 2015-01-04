//
//  DailySpendingsFetchRequest.swift
//  MyBudget
//
//  Created by Michal Moskala on 04/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import CoreData

class FetchRequest: NSFetchRequest {
	func setup() {}
}

class DailySpendingsFetchRequest: FetchRequest {
	
	override func setup() {
		let expressionDescription = NSExpressionDescription()
		expressionDescription.name = "value"
		expressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
		expressionDescription.expressionResultType = NSAttributeType.FloatAttributeType
		
		self.propertiesToFetch = [expressionDescription, "stringDateDescription"]
		self.propertiesToGroupBy = ["stringDateDescription"]
		self.resultType = NSFetchRequestResultType.DictionaryResultType
		self.sortDescriptors = [NSSortDescriptor(key: "stringDateDescription", ascending: false)]
	}
	
}
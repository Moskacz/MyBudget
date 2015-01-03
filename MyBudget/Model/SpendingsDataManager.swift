
//  SpendingsDataManager.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol SpendingsDataManagerDelegate {
	func dataManagerDidFetchDailySpendings()
}

class SpendingsDataManager {
	private let coreDataStack: CoreDataStack
	var dailySpendings: [DailySpending]?
	var delegate: SpendingsDataManagerDelegate?
	
	init() {
		self.coreDataStack = CoreDataStack()
		fetchDailySpendings()
	}
	
	func fetchDailySpendings() {
		let fetchRequest = NSFetchRequest()
		let entityDescription = NSEntityDescription.entityForName("Spending", inManagedObjectContext: self.coreDataStack.context)
		fetchRequest.entity = entityDescription
		
		let expressionDescription = NSExpressionDescription()
		expressionDescription.name = "value"
		expressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "value")])
		expressionDescription.expressionResultType = NSAttributeType.FloatAttributeType
		
		fetchRequest.propertiesToFetch = [expressionDescription, "stringDateDescription"]
		fetchRequest.propertiesToGroupBy = ["stringDateDescription"]
		fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
		
		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] (result: NSAsynchronousFetchResult!) -> Void in
			if let dailySpendings = result.finalResult as? [Dictionary<String, AnyObject>] {
				self.dailySpendings = dailySpendings.map( { (dict: Dictionary<String,AnyObject>) -> DailySpending in
					let date = dict["stringDateDescription"] as String
					let value = dict["value"] as Float
					return DailySpending(dateLiteral: date, value: NSNumber(float: value))
				})
			}
			self.delegate?.dataManagerDidFetchDailySpendings()
		}
		
		var fetchError: NSError? = nil
		self.coreDataStack.context.executeRequest(asyncFetchRequest, error: &fetchError)
	}

	func saveSpending(spendingDTO: SpendingDTO) {
		let entityDescription = NSEntityDescription.entityForName("Spending", inManagedObjectContext: self.coreDataStack.context)
		let spending = Spending(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.context)
		spending.value = spendingDTO.value
		spending.date = spendingDTO.date
		spending.stringDateDescription = spendingDTO.stringDateDescription
		self.coreDataStack.saveContext()
		fetchDailySpendings()
	}
	
}

//  SpendingsDataManager.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class SpendingsDataManager {
	private let coreDataStack: CoreDataStack
	var dailySpendings: [DailySpending]?
	var fetchedSpendings: [Spending]?
	
	init() {
		self.coreDataStack = CoreDataStack()
	}
	
	func fetchDailySpendings() {
		let fetchRequest = DailySpendingsFetchRequest(entityName: "Spending")
		fetchRequest.setup()
		
		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] (result: NSAsynchronousFetchResult!) -> Void in
			if let dailySpendings = result.finalResult as? [Dictionary<String, AnyObject>] {
				self.dailySpendings = dailySpendings.map( { (dict: Dictionary<String,AnyObject>) -> DailySpending in
					let date = dict["stringDateDescription"] as String
					let value = dict["value"] as Float
					return DailySpending(dateLiteral: date, value: NSNumber(float: value))
				})
			}
			NSNotificationCenter.defaultCenter().postNotificationName("aaa", object: nil)
		}
		
		var fetchError: NSError? = nil
		self.coreDataStack.context.executeRequest(asyncFetchRequest, error: &fetchError)
	}
	
	func fetchSpendingsForDay(day: NSDate) {
		let fetchRequest = NSFetchRequest(entityName: "Spending")
		let nextDay = day.dateByAddingTimeInterval(Constants.Time.SecondsInDay)
		fetchRequest.predicate = NSPredicate(format: "(date >= %@ AND date < %@)", day, nextDay)
		
		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] (result: NSAsynchronousFetchResult!) -> Void in
			self.fetchedSpendings = result.finalResult as? [Spending]
			NSNotificationCenter.defaultCenter().postNotificationName("aaa", object: nil)
		}
		
		var error: NSError?
		self.coreDataStack.context.executeRequest(asyncFetchRequest, error: &error)
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
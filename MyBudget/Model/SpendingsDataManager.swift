
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
	var dailySpendings: [Spending]?
	
	init() {
		self.coreDataStack = CoreDataStack()
		fetchDailySpendings()
	}
	
	func fetchDailySpendings() {
		let fetchRequest = NSFetchRequest(entityName: "Spending")
		var fetchError: NSError? = nil
		self.dailySpendings = self.coreDataStack.context.executeFetchRequest(fetchRequest, error: &fetchError) as [Spending]?		
	}
	
}
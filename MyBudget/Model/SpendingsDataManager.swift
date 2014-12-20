
//  SpendingsDataManager.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol SpendingsDataManagerDelegate {
	func dataHasChanged()
}

class SpendingsDataManager {
	private let coreDataStack: CoreDataStack
	var dailySpendings: [Spending]?
	var delegate: SpendingsDataManagerDelegate?
	
	init() {
		self.coreDataStack = CoreDataStack()
		fetchDailySpendings()
	}
	
	func fetchDailySpendings() {
		let fetchRequest = NSFetchRequest(entityName: "Spending")
		var fetchError: NSError? = nil
		self.dailySpendings = self.coreDataStack.context.executeFetchRequest(fetchRequest, error: &fetchError) as [Spending]?		
	}

	func saveSpendingWithDTO(spendingDTO: SpendingDTO) {
		let entityDescription = NSEntityDescription.entityForName("Spending", inManagedObjectContext: self.coreDataStack.context)
		let spending = Spending(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.context)
		spending.value = spendingDTO.value
		spending.date = spendingDTO.date
		spending.name = "test 2"
		self.coreDataStack.saveContext()
		
		if let delegate = self.delegate {
			delegate.dataHasChanged()
		}
	}
	
}
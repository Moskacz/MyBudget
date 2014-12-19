//
//  CoreDataStack.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
	
	var context: NSManagedObjectContext
	var coordinator: NSPersistentStoreCoordinator
	var model: NSManagedObjectModel
	var store: NSPersistentStore?
	
	init() {
		let modelURL = NSBundle.mainBundle().URLForResource("MyBudget", withExtension: "momd")!
		model = NSManagedObjectModel(contentsOfURL: modelURL)!
		coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)

		context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
		context.persistentStoreCoordinator = coordinator
		
		let storeURL = self.applicationDocumentsDirectory().URLByAppendingPathComponent("MyBudget.sqlite")
		var error: NSError? = nil
		store = coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error)
		
		if store == nil {
			println("NSPersistentStore initialization error: \(error?.description)")
			abort()
		}
	}
	
	func applicationDocumentsDirectory() -> NSURL {
		let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
		return urls[urls.count - 1] as NSURL
	}
	
	func saveContext() {
		var error: NSError? = nil
		if self.context.hasChanges && !self.context.save(&error) {
			println("Saving context error \(error!.localizedDescription), \(error!.userInfo)")
		}
	}
}
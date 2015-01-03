//
//  Spending.swift
//  MyBudget
//
//  Created by Michal Moskala on 03/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class Spending: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var name: String
    @NSManaged var value: NSNumber
    @NSManaged var stringDateDescription: String

}

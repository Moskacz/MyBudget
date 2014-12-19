//
//  Spending.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class Spending: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var value: NSNumber
    @NSManaged var date: NSDate

}

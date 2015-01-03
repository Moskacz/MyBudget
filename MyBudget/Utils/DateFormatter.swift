//
//  DateFormatter.swift
//  MyBudget
//
//  Created by Michal Moskala on 03/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import UIKit

class DateFormatter: NSDateFormatter {
	
	override init() {
		super.init()
		self.dateFormat = "dd/MM/yyyy\nhh:mm"		
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

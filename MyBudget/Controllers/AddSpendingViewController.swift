//
//  AddSpendingViewController.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import UIKit

class AddSpendingViewController: UIViewController {
	
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var value: UITextField!
	var dataManager: SpendingsDataManager!
	
  override func viewDidLoad() {
    super.viewDidLoad()		
	}
	
	@IBAction func addButtonTapped(sender: UIButton) {
		if value.text.utf16Count != 0 {
			let value = (self.value.text as NSString).floatValue
			let spendingDTO = SpendingDTO(date: self.datePicker.date, value: NSNumber(float: value))
			self.dataManager.saveSpendingWithDTO(spendingDTO)
		}
		
		dismissViewControllerAnimated(true, completion: nil)
	}
}

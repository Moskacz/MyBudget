//
//  AddSpendingViewController.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import UIKit

class AddSpendingViewController: UIViewController {
	
	@IBOutlet weak var addSpendingButton: UIButton!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var value: UITextField!
	var dataManager: SpendingsDataManager!
	
  override func viewDidLoad() {
    super.viewDidLoad()
		addSpendingButton.enabled = false
		value.delegate = self
	}
	
	private func dismissController() {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: Button Events Handling
	
	@IBAction func addButtonTapped(sender: UIButton) {
		if value.text.utf16Count != 0 {
			let value = (self.value.text as NSString).floatValue
			let spendingDTO = SpendingDTO(date: self.datePicker.date, value: NSNumber(float: value))
			self.dataManager.saveSpending(spendingDTO)
		}
		dismissController()
	}
	
	@IBAction func dismissButtonTapped(sender: UIButton) {
		dismissController()
	}
	
}

extension AddSpendingViewController: UITextFieldDelegate {
	
	// MARK: UITextFieldDelegate
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		if string == "" {
			self.addSpendingButton.enabled = textField.text.utf16Count > 1
		} else {
			self.addSpendingButton.enabled = (textField.text.utf16Count + string.utf16Count) > 0
		}
		return true
	}
}

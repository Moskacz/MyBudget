//
//  SpendingsViewController.swift
//  MyBudget
//
//  Created by Michal Moskala on 04/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import UIKit

class SpendingsViewController: UIViewController, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	var dataManager: SpendingsDataManager!
	var date: NSDate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.dataSource = self
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadData"), name: Constants.NotificationNames.ReloadData, object: nil)
		self.dataManager?.fetchSpendingsForDay(self.date!)
	}

	dynamic func reloadData() {
		self.tableView.reloadData()
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let spendings = self.dataManager.fetchedSpendings {
			return spendings.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("SpendingCell") as UITableViewCell
		let spending = self.dataManager.fetchedSpendings![indexPath.row]
		cell.textLabel?.text = spending.date.description
		return cell
	}
}

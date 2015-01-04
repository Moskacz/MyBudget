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
	let dataManager = SpendingsDataManager()
	var spendings: [Spending]?
	var date: NSDate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.dataSource = self
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("fetchData"), name: Constants.NotificationNames.ReloadData, object: nil)
		fetchData()
	}

	dynamic func fetchData() {
		self.dataManager.fetchSpendingsForDay(self.date!, completion: { (spendings) -> () in
			self.spendings = spendings
			self.tableView.reloadData()
		})
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let spendings = self.spendings {
			return spendings.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("SpendingCell") as UITableViewCell
		let spending = self.spendings![indexPath.row]
		cell.textLabel?.text = spending.date.description
		return cell
	}
}

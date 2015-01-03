//
//  SpendingsViewController.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import UIKit

class SpendingsViewController: UIViewController, UITableViewDataSource, SpendingsDataManagerDelegate {
	@IBOutlet weak var tableView: UITableView!
	let dataManager: SpendingsDataManager!

	required init(coder aDecoder: NSCoder) {
		dataManager = SpendingsDataManager()
		super.init(coder: aDecoder)
		dataManager.delegate = self
	}
	
  override func viewDidLoad() {
    super.viewDidLoad()
		self.tableView.dataSource = self
  }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if self.dataManager.dailySpendings != nil {
			return self.dataManager.dailySpendings!.count
		}
		return 0;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("SpendingsCell") as DailySpendingTableViewCell
		let dailySpending = self.dataManager.dailySpendings![indexPath.row]
		cell.setValue(dailySpending.value)
		cell.setDateLiteral(dailySpending.dateLiteral)
		return cell
	}
	
	// MARK: segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showAddSpendingVC" {
			let destinationVC = segue.destinationViewController as AddSpendingViewController
			destinationVC.dataManager = dataManager
		}
	}
	
	// MARK: SpendingsDataManagerDelegate
	
	func dataManagerDidFetchDailySpendings() {
		self.tableView.reloadData()
	}
}

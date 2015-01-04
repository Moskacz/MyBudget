//
//  SpendingsViewController.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import UIKit

class DailySpendingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	let dataManager = SpendingsDataManager()
	let dateFormatter = DateFormatter()
	var selectedDate: NSDate?
	var dailySpendings: [DailySpending]?

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("fetchData"), name: Constants.NotificationNames.ReloadData, object: nil)
	}
	
  override func viewDidLoad() {
    super.viewDidLoad()
		self.tableView.dataSource = self
		self.tableView.delegate = self
		fetchData()		
  }
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let spendings = self.dailySpendings {
			return spendings.count
		}
		
		return 0;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("DailySpendingsCell") as DailySpendingTableViewCell
		let dailySpending = self.dailySpendings![indexPath.row]
		cell.setValue(dailySpending.value)
		cell.setDateLiteral(dailySpending.dateLiteral)
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let dailySpending = self.dailySpendings![indexPath.row]
		self.selectedDate = self.dateFormatter.dateFromString(dailySpending.dateLiteral)
		performSegueWithIdentifier("showSpendings", sender: nil)
	}
	
	// MARK: segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showSpendings" {
			let destinationVC = segue.destinationViewController as SpendingsViewController			
			destinationVC.date = self.selectedDate
		}
	}
	
	dynamic func fetchData() {
		self.dataManager.fetchDailySpendings { (dailySpendings) -> () in
			self.dailySpendings = dailySpendings
			self.tableView.reloadData()
		}
	}
}

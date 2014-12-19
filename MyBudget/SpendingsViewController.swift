//
//  SpendingsViewController.swift
//  MyBudget
//
//  Created by Michal Moskala on 19/12/14.
//  Copyright (c) 2014 Michal Moskala. All rights reserved.
//

import UIKit

class SpendingsViewController: UIViewController, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
		self.tableView.dataSource = self
  }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("SpendingsCell") as UITableViewCell
		cell.textLabel?.text = "test"
		return cell
	}
	
}

//
//  NavigationController.swift
//  MyBudget
//
//  Created by Michal Moskala on 04/01/15.
//  Copyright (c) 2015 Michal Moskala. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
	
	override func viewDidLoad() {
    super.viewDidLoad()
		self.delegate = self
  }
	
	// MARK: UINavigationControllerDelegate
	
	func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
		viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: Selector("presentAddSpendingViewController"))
	}
	
	func presentAddSpendingViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)		
		let addSpendingVC = storyboard.instantiateViewControllerWithIdentifier("AddSpendingViewController") as AddSpendingViewController
		presentViewController(addSpendingVC, animated: true, completion: nil)
	}	

}

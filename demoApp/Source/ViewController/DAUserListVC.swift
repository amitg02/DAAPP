//
//  DAUserListVC.swift
//  demoApp
//
//  Created by Atal Bansal on 04/07/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit
import RealmSwift

class DAUserListVC: UIViewController {
	
	@IBOutlet weak var userTableView:UITableView!
	
	var users : Results<DAUserModel>!
	let realmUserModel = RealmUserModel()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		SetInitalValue()
        // Do any additional setup after loading the view.
    }
	func SetInitalValue(){
		 users = realmUserModel.fetchUserListsRealm()
		userTableView.estimatedRowHeight = 44.0
		userTableView.rowHeight = UITableViewAutomaticDimension
		userTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		userTableView.tableFooterView = UIView()
	}
	func reloadTable(){
		users = realmUserModel.fetchUserListsRealm()
		userTableView.reloadData()
	}
	func pushToEditMode(userToBeEdited:DAUserModel){
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("DALoginRegisterVC") as! DALoginRegisterVC
		vc.screenType = 3
		vc.userDic = userToBeEdited
		self.navigationController!.pushViewController(vc, animated: true)
		
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DAUserListVC:UITableViewDataSource {
	// DataSource
	func numberOfSectionsInTableView(tableview: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(DAUserListTVC.DATableViewCellIdentifier, forIndexPath: indexPath) as! DAUserListTVC
		let user = users[indexPath.row]
		if user.userImage.length != 0 {
			cell.userImageView.image = UIImage(data:user.userImage,scale:1.0)
		}
		cell.userNameLbl.text = user.userName
		cell.userEmailLbl.text = "\(user.userEmail), \(user.userMobile)"
		
		return cell
		
	}
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		// Okie dokie
	}

	func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
		let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
			let userToBeDeleted = self.users[indexPath.row]
			self.realmUserModel.deleteUserRealm(userToBeDeleted)
			self.reloadTable()
		}
		let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
			let userToBeUpdated = self.users[indexPath.row]
			self.pushToEditMode(userToBeUpdated)
//self.dispalyAlertViewForUser(userToBeUpdated)
		}
		return [deleteAction, editAction]
	}
 
	
	
}
extension DAUserListVC:UITableViewDelegate{
	// Delegate
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
	
}

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
	
	@IBOutlet weak var userCollectionView:UICollectionView!
	
	var users : Results<DAUserModel>!
	let realmUserModel = RealmUserModel()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		SetInitalValue()
        // Do any additional setup after loading the view.
    }
	func SetInitalValue(){
		 users = realmUserModel.fetchUserListsRealm()
		userCollectionView.reloadData()
		userCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DAUserListVC : UICollectionViewDelegate{
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
	}
}
extension DAUserListVC : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
		return 1
	}
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print("users.count:\(users.count)")
		return users.count
	}
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
		
		let reuseIdentifier = "userList"
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DAUserListCVC
		let user = users[indexPath.row]
		if user.userImage.length != 0 {
			cell.userImageView.image = UIImage(data:user.userImage,scale:1.0)
		}
		
		cell.userNameLbl.text = user.userName
		cell.userEmailLbl.text = "\(user.userEmail), \(user.userMobile)"
		return cell
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		
		return CGSizeMake(UIScreen.mainScreen().bounds.width, 80)
	
	}
	
}
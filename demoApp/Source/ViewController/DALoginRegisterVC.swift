//
//  ViewController.swift
//  demoApp
//
//  Created by Atal Bansal on 27/06/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit

class DALoginRegisterVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
	
	@IBOutlet weak var tableview:UITableView!
	
	let daloginRegisterModelObject = DALoginRegisterViewModel()
	
	var tableViewArr:NSMutableArray = NSMutableArray()
	var screenType:Int = 1
	var userDic:DAUserModel =  DAUserModel()
	let imagePicker = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		SetInitalValue()
				// Do any additional setup after loading the view, typically from a nib.
	}
	func SetInitalValue(){
		if screenType == 3 {
			tableViewArr = daloginRegisterModelObject.createTableDic(screenType,userDic: userDic)
		} else {
		tableViewArr = daloginRegisterModelObject.createTableDic(screenType,userDic: nil)
		}
		tableview.estimatedRowHeight = 44.0
		tableview.rowHeight = UITableViewAutomaticDimension
		tableview.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
		tableview.tableFooterView = UIView()

		
	}
	// MARK: imagePicker delegate
	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
		//imagePicked = image
		let nextCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow:0, inSection:0))! as UITableViewCell
		if nextCell .isKindOfClass(DAImageViewTVC){
			let nextCell1 = nextCell as! DAImageViewTVC
			nextCell1.logoImageView.image = image
			let dic = tableViewArr[0] as! NSDictionary
			dic .setValue(UIImagePNGRepresentation(image), forKey: "text")
			self.tableViewArr.replaceObjectAtIndex(0, withObject: dic)
		}

		self.dismissViewControllerAnimated(true, completion: nil);
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}
extension DALoginRegisterVC:UITableViewDataSource {
	// DataSource
	func numberOfSectionsInTableView(tableview: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewArr.count
	}
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell?
		let dic = tableViewArr[indexPath.row] as! NSDictionary
		switch  dic["cellType"] as! String {
		case  CellType.DAImageView.rawValue :
			let imageViewCell = tableView.dequeueReusableCellWithIdentifier(DAImageViewTVC.DAImageViewCellIdentifier, forIndexPath: indexPath) as! DAImageViewTVC
			if screenType == 1 {
				imageViewCell.logoImageView.userInteractionEnabled = false
			}else {
				imageViewCell.logoImageView.userInteractionEnabled = true
			}
			if screenType == 3 {
				imageViewCell.logoImageView.image = UIImage(data:dic["text"] as! NSData, scale:1.0)
			}
			//imageViewCell.logoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DALoginRegisterVC.imageTapped(_:))))
			imageViewCell.onImageChangedFieldTextChanged = { text in
				self.imageTapped()
			}
				cell = imageViewCell
		case  CellType.DATextField.rawValue :
			let emailCell = tableView.dequeueReusableCellWithIdentifier(DATextFieldTVC.DATextFieldCellIdentifier, forIndexPath: indexPath) as! DATextFieldTVC
			emailCell.placeholder   = dic["placeholderText"] as? String
			emailCell.value		    = dic["text"] as? String
			emailCell.secure	    = dic["secureType"] as? Bool
			emailCell.keyboardType  = dic["keyboardType"] as? String
			emailCell.onFieldReturn = {
				let nextCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section))! as UITableViewCell
				if nextCell .isKindOfClass(DATextFieldTVC){
					let nextCell1 = nextCell as! DATextFieldTVC
					nextCell1.userTextField.becomeFirstResponder()
					}
				}
			emailCell.onFieldTextChanged = { text in
				dic .setValue(text, forKey: "text")
				self.tableViewArr.replaceObjectAtIndex(indexPath.row, withObject: dic)
			}
			cell = emailCell
		case  CellType.DASubmitBtn.rawValue :
			let submitBtnCell = tableView.dequeueReusableCellWithIdentifier(DASubmitBtnTVC.DATextFieldCellIdentifier, forIndexPath: indexPath) as! DASubmitBtnTVC
			submitBtnCell.submitBtn.tag   = indexPath.row
			submitBtnCell.btnTitle		  = dic["placeholderText"] as? String
			submitBtnCell.newUserBtnTitle = dic["newUserBtnTitle"] as? String
			submitBtnCell.submitBtn.addTarget(self, action: #selector(DALoginRegisterVC.btnPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
			submitBtnCell.newUserBtn.addTarget(self, action: #selector(DALoginRegisterVC.newUserBtnPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
			cell = submitBtnCell
		default: break
		}
		return cell!

	}
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		// Okie dokie
	}
	func imageTapped() {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
			imagePicker.allowsEditing = false
			self.presentViewController(imagePicker, animated: true, completion: nil)
		}else {
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
			imagePicker.allowsEditing = true
			self.presentViewController(imagePicker, animated: true, completion: nil)
		}
	}
	func btnPressed(sender:UIButton) {
		let (status,message,count,user) = daloginRegisterModelObject.submitBtnPressed(tableViewArr,screenType: screenType,userDic: userDic)
		if  status {
			print("VAlidationPass::\(user)")
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let vc = storyboard.instantiateViewControllerWithIdentifier("TabbarControllerID") as! UITabBarController
			self.presentViewController(vc, animated: true, completion: nil)


		} else {
			if count == "NIL" {
				
			} else{
			let nextCell = tableview.cellForRowAtIndexPath(NSIndexPath(forRow:Int(count)!, inSection:0))! as UITableViewCell
			if nextCell .isKindOfClass(DATextFieldTVC){
				let nextCell1 = nextCell as! DATextFieldTVC
				nextCell1.userTextField.becomeFirstResponder()
				}
			}
			DACommonMethod.showAlert(message)
		}
	}
	func newUserBtnPressed(sender:UIButton) {
		if screenType == 1 {
			screenType = 2
		} else {
			screenType = 1
		}
		tableViewArr = daloginRegisterModelObject.createTableDic(screenType,userDic: nil)
		UIView.setAnimationsEnabled(false)
		tableview.reloadData()
		UIView.setAnimationsEnabled(true)
	}
	

	
}
extension DALoginRegisterVC:UITableViewDelegate{
	// Delegate
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
	
}


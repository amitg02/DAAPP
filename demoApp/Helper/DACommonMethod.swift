//
//  DACommonMethod.swift
//  demoApp
//
//  Created by Atal Bansal on 02/07/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit

class DACommonMethod: NSObject {
	
	class func validateNameWithString(name:String, withIdentifier:String)->(Bool,String){
		
		if (name.isEmpty || name.length == 0) {
			let str = String(format: "please enter %@", withIdentifier)
			return (false,str)
		}
		
		if name.length > 24{
			let str = String(format: "%@ can contain atmost 24 characters", withIdentifier)
			return (false,str)
		}
		
		let nameRegex:String = "[a-zA-Z0-9_.@ ]+$"
		let nameTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@",nameRegex)
		if !nameTest .evaluateWithObject(name){
			let str = String(format: "please enter valid %@", withIdentifier)
			return (false,str)
		}
		return (true,"")
	}

	
	class func validatePhoneNumberWithString(number:String, withIdentifier:String)->(Bool,String) {
	if (number.isEmpty || number.length == 0) {
	let str = String(format: "please enter %@", withIdentifier)
	return (false,str)
	}
	
	let numberRegex:String = "[0-9+]+$"
	let numberTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@",numberRegex)
	if !numberTest .evaluateWithObject(number){
	let str = String(format: "please enter valid %@", withIdentifier)
	return (false,str)
	}
	return (true,"")
	}

	class func validateEmailWithString(email:String, withIdentifier:String)->(Bool,String){
	if (email.isEmpty || email.length == 0) {
		let str = String(format: "please enter %@", withIdentifier)
		return (false,str)
	}
	let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
	let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@",emailRegex)
	if !emailTest .evaluateWithObject(email){
		let str = String(format: "please enter valid %@", withIdentifier)
		return (false,str)
	}
	return (true,"")
	}
	class func validatePasswordWithString(password:String, withIdentifier:String)->(Bool,String){
	if (password.isEmpty || password.length == 0) {
		let str = String(format: "please enter %@", withIdentifier)
		return (false,str)
	}
	if password.length < 6{
		let str = String(format: "%@ should contain atleast 6 characters", withIdentifier)
		return (false,str)
	}
	if password.length > 20{
		let str = String(format: "%@ can contain atmost 20 characters", withIdentifier)
		return (false,str)
	}
	return (true,"")
	}
	class func validateConfirmPassword(password:String,confirmPassword:String, withIdentifier:String)->(Bool,String){
		if password == confirmPassword {
			return (true,"")
		} else{
			let str = String(format: "Password and Confirm password must be same")
			return (false,str)

		}
		
	}
	class func showAlert(alertMsg:String){
		let actionSheetController: UIAlertController = UIAlertController(title: "App", message: alertMsg, preferredStyle: .Alert)
		
		actionSheetController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { alertAction in
			actionSheetController.dismissViewControllerAnimated(true, completion: nil)
		}))
		
		let appDelegate = UIApplication.sharedApplication().delegate as! DAAppDelegate
		let viewController = appDelegate.window?.rootViewController
		viewController?.presentViewController(actionSheetController, animated: true, completion: nil)
		
	}

}

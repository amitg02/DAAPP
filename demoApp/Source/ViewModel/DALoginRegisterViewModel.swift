//
//  DAloginRegisterViewModel.swift
//  demoApp
//
//  Created by Atal Bansal on 01/07/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit
import RealmSwift

class DALoginRegisterViewModel: NSObject {
	
	let realmUserModel = RealmUserModel()
	var users : Results<DAUserModel>!
	
	func createTableDic(screenType:Int,userDic:DAUserModel?)->NSMutableArray {
		let arr:NSMutableArray
		if screenType == 2 {
			let logoDic:NSMutableDictionary		= ["index":"0","cellType" : CellType.DAImageView.rawValue, "placeholderText" : " ","text":"","secureType":false,"keyboardType": "Default"]
			let userNameDic:NSMutableDictionary	= ["index":"1","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Name","text":"","secureType":false,"keyboardType":"Default"]
			let userMobileDic:NSMutableDictionary	= ["index":"2","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Mobile","text":"","secureType":false,"keyboardType":"PhonePad"]
			let emailDic:NSMutableDictionary	= ["index":"3","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Email","text":"","secureType":false,"keyboardType":"EmailAddress"]
			let passwordDic:NSMutableDictionary = ["index":"4","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Password","text":"","secureType":true,"keyboardType":"Default"]
			let confirmPasswordDic:NSMutableDictionary = ["index":"5","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Confirm Password","text":"","secureType":true,"keyboardType":"Default"]
			let buttonDic:NSMutableDictionary	= ["index":"6","cellType" : CellType.DASubmitBtn.rawValue, "placeholderText" : " Register","text":"","secureType":false,"keyboardType":"Default","newUserBtnTitle":"Already have Account?"]
		 arr = NSMutableArray(objects: logoDic,userNameDic,userMobileDic,emailDic,passwordDic,confirmPasswordDic,buttonDic)
		}  else if screenType == 3 {
			let logoDic:NSMutableDictionary		= ["index":"0","cellType" : CellType.DAImageView.rawValue, "placeholderText" : " ","text":(userDic?.userImage)!,"secureType":false,"keyboardType": "Default"]
			let userNameDic:NSMutableDictionary	= ["index":"1","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Name","text":(userDic?.userName)!,"secureType":false,"keyboardType":"Default"]
			let userMobileDic:NSMutableDictionary	= ["index":"2","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Mobile","text":(userDic?.userMobile)!,"secureType":false,"keyboardType":"PhonePad"]
			let emailDic:NSMutableDictionary	= ["index":"3","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Email","text":(userDic?.userEmail)!,"secureType":false,"keyboardType":"EmailAddress"]
			let buttonDic:NSMutableDictionary	= ["index":"6","cellType" : CellType.DASubmitBtn.rawValue, "placeholderText" : " Update","text":"","secureType":false,"keyboardType":"Default","newUserBtnTitle":""]
		 arr = NSMutableArray(objects: logoDic,userNameDic,userMobileDic,emailDic,buttonDic)
		} else {
			let logoDic:NSMutableDictionary		= ["index":"0","cellType" : CellType.DAImageView.rawValue, "placeholderText" : "","text":"","secureType":false,"keyboardType":"Default"]
			let emailDic:NSMutableDictionary	= ["index":"1","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Email","text":"amit4@gmail.com","secureType":false,"keyboardType":"Default"]
			let passwordDic:NSMutableDictionary = ["index":"2","cellType" : CellType.DATextField.rawValue, "placeholderText" : "Password","text":"123456","secureType":true,"keyboardType":"Default"]
			let buttonDic:NSMutableDictionary	= ["index":"3","cellType" : CellType.DASubmitBtn.rawValue, "placeholderText" :"Login","text":"","secureType":false,"keyboardType":"Default","newUserBtnTitle":"New User Register"]
		 arr = NSMutableArray(objects: logoDic,emailDic,passwordDic,buttonDic)
		}
		return arr
	}
	func submitBtnPressed(dataArr:NSMutableArray,screenType:Int,userDic:DAUserModel?)->(Bool,String,String,DAUserModel?){
		var returnTuple: (status: Bool, message: String)? = nil
		let dataDic:NSMutableDictionary = NSMutableDictionary()
		for dic in dataArr {
			if dic["cellType"] as! String == "DATextField" {
				let inputText = dic["text"] as! String
				let placeholderText = dic["placeholderText"] as! String
				if placeholderText == "Email" {
					dataDic.setObject(inputText, forKey:placeholderText)
				returnTuple = DACommonMethod.validateEmailWithString(inputText, withIdentifier: dic["placeholderText"] as! String)
				} else if placeholderText == "Mobile" {
					dataDic.setObject(inputText, forKey:placeholderText)
					returnTuple = DACommonMethod.validatePhoneNumberWithString(inputText, withIdentifier: dic["placeholderText"] as! String)
					
				} else if placeholderText == "Password" {
					dataDic.setObject(inputText, forKey:placeholderText)
					returnTuple = DACommonMethod.validatePasswordWithString(inputText, withIdentifier: dic["placeholderText"] as! String)
					
				} else if placeholderText == "Name" {
					dataDic.setObject(inputText, forKey:placeholderText)
					returnTuple = DACommonMethod.validateNameWithString(inputText, withIdentifier: dic["placeholderText"] as! String)
				} else if placeholderText == "Confirm Password" {
					dataDic.setObject(inputText, forKey:placeholderText)
					returnTuple = DACommonMethod.validatePasswordWithString(inputText, withIdentifier: dic["placeholderText"] as! String)
					
				}
				guard  returnTuple!.status
					else {
						return (returnTuple!.status,returnTuple!.message,dic["index"] as! String,nil)
				}
			}
			if screenType == 2  || screenType == 3 {
			if dic["cellType"] as! String == "DAImageView" {
				dataDic.setObject(dic["text"] as! NSData, forKey:"image")
			}
		 }
		}
		if screenType == 2 {
			let (status,message) = DACommonMethod.validateConfirmPassword(dataDic.objectForKey("Password") as! String, confirmPassword: dataDic.objectForKey("Confirm Password") as! String, withIdentifier: "")
			if status {
				return insertUserDeatilsInRealm(dataDic)
			} else {
				return (status,message,"NIL",nil)
			}
		} else if screenType == 3 {
			return updateUserRealm(dataDic,userDic: userDic!)
		} else {
			return fetchUserDetailsOnLogin(dataDic)
		}
	}
	func fetchUserDetailsOnLogin(dic:NSMutableDictionary)->(Bool,String,String,DAUserModel?){
		let user =  self.realmUserModel.fetchSingleUserRecords(dic.objectForKey("Email") as! String, userPassword: dic.objectForKey("Password") as! String)
		let arrayTmp = Array(user)
		let ArrayPerson = arrayTmp as NSArray
		if user.count == 0 {
			return (false,"Email and password wrong","NIL",nil)
		} else {
			let userModel = ArrayPerson.objectAtIndex(0) as! DAUserModel
			return (true,"Successfully login","NIL",userModel)
		}
	}
	func insertUserDeatilsInRealm(dic:NSMutableDictionary)->(Bool,String,String,DAUserModel?){
		 let emailAlreadyExist = realmUserModel.fetchSingleUserRecords(dic.objectForKey("Email") as! String,userPassword: "")
		if emailAlreadyExist.count == 0 {
			let userModel = DAUserModel()
			userModel.userName     = dic.objectForKey("Name") as! String
			userModel.userEmail	   = dic.objectForKey("Email") as! String
			userModel.userMobile   = dic.objectForKey("Mobile") as! String
			userModel.userPassword = dic.objectForKey("Password") as! String
			userModel.userImage    = dic.objectForKey("image") as! NSData
		  users = realmUserModel.fetchUserListsRealm()
			if let userList = self.users {
				userModel.userID = "\(userList.count + 1)"
			} else {
				userModel.userID = "1"
			}
			
			let (status,message) = self.realmUserModel.insertOrUpdateUserRealm(userModel,updateStatus:false,updatedUserModel:nil)
			if status {
				let user = uiRealm.objectForPrimaryKey(DAUserModel.self, key: userModel.userID)
				print("userscount:\(users.count) and \(user)")
				return (status,message,message,user)
			} else {
				return (status,message,message,nil)
			}
		} else {
			return (false,"Email alredy Exists","NIL",nil)
		}
	}
	func updateUserRealm(dic:NSMutableDictionary,userDic:DAUserModel)->(Bool,String,String,DAUserModel?){
		
			// update mode
		let userModel = DAUserModel()
		userModel.userName     = dic.objectForKey("Name") as! String
		userModel.userEmail	   = dic.objectForKey("Email") as! String
		userModel.userMobile   = dic.objectForKey("Mobile") as! String
		userModel.userImage    = dic.objectForKey("image") as! NSData
		userModel.userPassword = userDic.userPassword

		let (status,message) = self.realmUserModel.insertOrUpdateUserRealm(userDic,updateStatus:true,updatedUserModel:userModel)
		if status {
			let user = uiRealm.objectForPrimaryKey(DAUserModel.self, key: userModel.userID)
			return (status,message,message,user)
		} else {
			return (status,message,message,nil)
		}

		
	}

}

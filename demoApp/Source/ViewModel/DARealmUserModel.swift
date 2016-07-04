//
//  HomeViewControllerModel.swift
//  SAAM
//
//  Created by Atal Bansal on 23/05/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUserModel:NSObject{
  var lists : Results<DAUserModel>!
  func insertOrUpdateUserRealm(userModel:DAUserModel,updateStatus:Bool,updatedUserModel:DAUserModel!)->(Bool,String){
   
    if updateStatus {
      // update mode
      let updatedUser = DAUserModel()
        updatedUser.userEmail    = userModel.userEmail
        updatedUser.userName     = userModel.userName
        updatedUser.userID       = userModel.userID
		updatedUser.userMobile   = userModel.userMobile
		updatedUser.userPassword = userModel.userPassword
		updatedUser.userImage    = userModel.userImage
      do {
        try uiRealm.write({ () -> Void in
          userModel.userName	 = updatedUserModel.userName
          userModel.userEmail	 = updatedUserModel.userEmail
		  userModel.userMobile	 = updatedUserModel.userMobile
		  userModel.userPassword = updatedUserModel.userPassword
          })
      }catch {
        print("err")
		return (false,"user updation failed")
      }
    }
    else{
      do {
        try  uiRealm.write { () -> Void in
          uiRealm.add(userModel,update: true)
		}
      }catch {
        print("err")
		return (false,"user insertion failed")

      }
      
    }
	return (true,"user successfully inserted")
  }
  
  func deleteUserRealm(listToBeDeleted:DAUserModel){
    do {
      try   uiRealm.write({ () -> Void in
        uiRealm.delete(listToBeDeleted)
        
      })
    }catch {
      print("err")
    }
  }
  
  func fetchUserListsRealm()->Results<DAUserModel>{
      lists = uiRealm.objects(DAUserModel)
      return lists
    }
	func fetchSingleUserRecords(userEmail:String,userPassword:String)->Results<DAUserModel>{
		lists = uiRealm.objects(DAUserModel)
		if userPassword.length != 0 {
		let userArr =  lists.filter("userEmail == '\(userEmail)' and userPassword == '\(userPassword)'")
			return userArr
		} else{
			let userArr =  lists.filter("userEmail == '\(userEmail)'")
			print("useerAA\(userArr)")
			return userArr

		}
	}
}
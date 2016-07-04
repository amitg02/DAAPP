//
//  UserModel.swift
//  demoApp
//
//  Created by Atal Bansal on 02/07/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import Foundation
import RealmSwift

class DAUserModel: Object {
	
	dynamic var userID		     = ""
	dynamic var userName	     = ""
	dynamic var userEmail	     = ""
	dynamic var userMobile		 = ""
	dynamic var userImage:NSData = NSData()
	dynamic var userPassword     = ""
	
	override static func primaryKey() -> String? {
		return "userID"
	}}

//
//  DAUserListCVC.swift
//  demoApp
//
//  Created by Atal Bansal on 04/07/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit

class DAUserListCVC: UICollectionViewCell {
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var userNameLbl: UILabel!
	@IBOutlet weak var userEmailLbl: UILabel!
	static let DACollectionViewCellIdentifier:String = "userList"
}

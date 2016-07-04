//
//  DASubmitBtnTVC.swift
//  demoApp
//
//  Created by Atal Bansal on 27/06/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit

class DASubmitBtnTVC: UITableViewCell {
	
	@IBOutlet weak var submitBtn: UIButton!
	@IBOutlet weak var newUserBtn: UIButton!
	
	static let DATextFieldCellIdentifier:String = "submitBtn"
	
	var btnTitle:String? {
		didSet {
			if let text = btnTitle {
				submitBtn.setTitle(text, forState: UIControlState.Normal)
			} else {
				submitBtn.setTitle("", forState: UIControlState.Normal)
			}
		}
	}
	var newUserBtnTitle:String? {
		didSet {
			if let text = newUserBtnTitle {
				newUserBtn.setTitle(text, forState: UIControlState.Normal)
			} else {
				newUserBtn.setTitle("", forState: UIControlState.Normal)
			}
		}
	}
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

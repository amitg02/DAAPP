//
//  DATextFieldTVC.swift
//  demoApp
//
//  Created by Atal Bansal on 27/06/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit

class DATextFieldTVC: UITableViewCell {

	@IBOutlet weak var userTextField: UITextField!
	
	static let DATextFieldCellIdentifier:String = "textField"
	
	var value:String? {
		set {
			if let text = newValue {
				userTextField.text = text
			} else {
				userTextField.text = ""
			}
		}
		get {
			return userTextField.text
		}
	}
	var placeholder:String? {
		didSet {
			if let text = placeholder {
				userTextField.placeholder = text
			} else {
				userTextField.placeholder = ""
			}
		}
	}
	var secure:Bool? {
		didSet {
			userTextField.secureTextEntry = secure!
		}
	}
	var keyboardType:String! {
		didSet {
			switch  keyboardType {
			case "PhonePad":
				userTextField.keyboardType = UIKeyboardType.PhonePad
			case "EmailAddress":
				userTextField.keyboardType = UIKeyboardType.EmailAddress
			default:
				userTextField.keyboardType = UIKeyboardType.Default
			}
		}
	}
	var onFieldTextChanged:((text:String?) -> ())?
	var onFieldReturn:(Void -> ())?
	
	private var tapGesture:UITapGestureRecognizer!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		tapGesture = UITapGestureRecognizer(target: self, action: #selector(fieldTapOutside))
		tapGesture.cancelsTouchesInView = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	///////////////////////////////////////////////
	// MARK: - Field callback
	///////////////////////////////////////////////
	
	@IBAction func fieldValueChanged(sender: UITextField) {
		self.onFieldTextChanged?(text: userTextField.text)
	}
	@IBAction func fieldEditingBegin(sender: UITextField) {
		window?.addGestureRecognizer(tapGesture)
	}
	@IBAction func fieldEditingEnd(sender: UITextField) {
		window?.removeGestureRecognizer(tapGesture)
	}
	@IBAction func fieldDidEndOnExit(sender: UITextField) {
		self.onFieldReturn?()
	}
	@objc func fieldTapOutside() {
		userTextField.resignFirstResponder()
	}

}

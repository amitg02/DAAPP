//
//  DAImageViewTVC.swift
//  demoApp
//
//  Created by Atal Bansal on 02/07/16.
//  Copyright © 2016 Atal Bansal. All rights reserved.
//

import UIKit

class DAImageViewTVC: UITableViewCell {
	
	@IBOutlet weak var logoImageView: UIImageView!
	static let DAImageViewCellIdentifier:String = "imageView"
	
	var onImageChangedFieldTextChanged:((text:NSData?) -> ())?
	override func awakeFromNib() {
		super.awakeFromNib()
		logoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DAImageViewTVC.imageTapped(_:))))
		// Initialization code
	}
	func imageTapped(sender: UITapGestureRecognizer) {
		self.onImageChangedFieldTextChanged?(text:UIImagePNGRepresentation(logoImageView.image!))

	}

}
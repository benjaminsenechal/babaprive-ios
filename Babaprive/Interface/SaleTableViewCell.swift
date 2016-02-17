//
//  SaleTableViewCell.swift
//  Babaprive
//
//  Created by Benjamin SENECHAL on 19/01/2016.
//  Copyright © 2016 Benjamin SENECHAL. All rights reserved.
//

import UIKit
import Kingfisher

class SaleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webSiteLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    let detailsViewHeight : CGFloat = 128.0
    var onStateUpdate: (()->Void)?
    @IBOutlet weak var extendButton: UIButton!

    @IBOutlet weak var bottomDetailsViewHeightLayoutConstraint: NSLayoutConstraint!
    
    var showsDetails = false {
        didSet {
            bottomDetailsViewHeightLayoutConstraint.priority = showsDetails ? 250 : 999
            editText()
        }
    }
    
    func editText() {
        extendButton.titleLabel?.text = showsDetails ? "-" : "+"
    }
    
    var sale : Sale! {
        didSet {
            titleLabel.text = sale.title
            webSiteLabel.text = sale.website
            
            headerImageView.kf_setImageWithURL(NSURL(string: sale.imageUrl)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomDetailsViewHeightLayoutConstraint.constant = 0
    }
    
    @IBAction func showDetailsAction(sender: AnyObject) {
        editText()
        self.onStateUpdate?()
    }

}

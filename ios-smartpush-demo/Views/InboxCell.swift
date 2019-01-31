//
//  InboxCell.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 09/01/19.
//  Copyright © 2019 Carlos Correa. All rights reserved.
//

import UIKit

class InboxCell: UITableViewCell {

    static let identifier = "inboxCell"
    
    @IBOutlet weak var tfLat: UITextField!
    @IBOutlet weak var tfLng: UITextField!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imagebanner: UIImageView!
    @IBOutlet weak var btExtra: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var button: UIButton!
    
    var buttonAction: ((Any) -> Void)?
    
    @objc func buttonPressed(sender: Any) {
        self.buttonAction?(sender)
    }
    
//    @IBAction func extraButtonPressed(_ sender: Any) {
//
//        guard let cell = sender.superview?.superview as? InboxCell else {
//            return // or fatalError() or whatever
//        }
//
//        let indexPath = itemTable.indexPath(for: cell)
//        let obj = self.notifications[indexPath.row]
//
//        SmartpushSDK.sharedInstance()?.requestExtraContent(for: obj.pushid)
//    }
    
}

//
//  CallTableViewCell.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 24/6/2023.
//

import UIKit

class CallTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var callIV: UIImageView!
    @IBOutlet weak var callinfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var call: Calls!{
        didSet {
            self.dateLabel.text = call.deliveryDate
            self.nameLabel.text = call.buddyName
            self.profileIV.image = UIImage(named: call.profileImageName)
            self.dateLabel.text = call.deliveryDate
            self.callinfo.text = call.infoimg
            self.callIV.image = UIImage(named : call.callimage)
            switch call.callType {
            case .ingoing:
                self.callinfo.text = "Ingoing Call"
                break
            case .outgoing:
                self.callinfo.text = "Outgoing Call"
                break
            case .missed:
                self.callinfo.text = "Missed Call"
               
                break
            case .video:
                self.callinfo.text = "Video Call"
                break
            }
        }
    }
}

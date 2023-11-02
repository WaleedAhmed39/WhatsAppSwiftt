//
//  StatusTableViewCell.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 26/6/2023.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plussign: UIImageView!
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var addlabel: UILabel!
    @IBOutlet weak var editimg: UIImageView!
    @IBOutlet weak var cameraimg: UIImageView!
    @IBOutlet weak var statuslabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var status: Status!{
        didSet {
            self.statuslabel.text = status.buddyName
            self.profileIV.image = UIImage(named: status.profileImageName)
            self.plussign.image = UIImage(named: status.callimage)
            
        }
    }
}


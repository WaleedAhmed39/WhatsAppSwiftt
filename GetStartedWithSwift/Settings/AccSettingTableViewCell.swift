//
//  AccSettingTableViewCell.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 12/7/2023.
//

import UIKit

class AccSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var AccName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var accsetting: AccSettings!{
        didSet {
            self.AccName.text = accsetting.SettingName
           
        }
    }
    
}

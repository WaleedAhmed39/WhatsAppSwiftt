//
//  ChatSendTextMessageTVC.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 25/06/2023.
//

import UIKit

class ChatSendTextMessageTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleImage.image = UIImage(named: "chat_bubble_sent")!.resizableImage(withCapInsets:
                                                                                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                                                               resizingMode: .stretch)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleImage: UIImageView!
    @IBOutlet weak var dileveryStatusIV: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    var message:Message! {
        didSet {
            dileveryStatusIV.image = UIImage(named: "read_check_marker")!
            dileveryStatusIV.tintColor = UIColor(named: "ThemeBlueColor")!
            switch self.message.deliveryStatus {
            case .deliver:
                dileveryStatusIV.image = UIImage(named: "send_chat_marker")
                dileveryStatusIV.tintColor = .darkGray
                break
            case .notSent:
                dileveryStatusIV.image = UIImage(named: "ic_message_not_sent")!
                dileveryStatusIV.tintColor = .darkGray
                break
            case .send:
                dileveryStatusIV.image = UIImage(named: "read_check_marker")!
                dileveryStatusIV.tintColor = .darkGray
                break
            case .seen:
                dileveryStatusIV.image = UIImage(named: "read_check_marker")!
                dileveryStatusIV.tintColor = UIColor(named: "ThemeBlueColor")
                break
            }
            timeLabel.text =  ""
            timeLabel.sizeToFit()
            
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1
            paragraphStyle.alignment = .justified
            
            let attributedTextNormal = NSMutableAttributedString(string: message.text, attributes: [ NSAttributedString.Key.kern: 0.1, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: FontFamily.SFProText.Regular.font(size: 14)!,.foregroundColor: UIColor.black,.baselineOffset:0 ])
            
            let paragraphStyle1 = NSMutableParagraphStyle()
            paragraphStyle1.lineHeightMultiple = 1
            paragraphStyle1.alignment = .right
            let attributedTextNormalDate = NSMutableAttributedString(string: message.sendingTime.getSeenTime, attributes: [ NSAttributedString.Key.kern: 0.1, NSAttributedString.Key.paragraphStyle: paragraphStyle1, NSAttributedString.Key.font: FontFamily.SFProText.Regular.font(size: 10)!,.foregroundColor: UIColor.darkGray,.baselineOffset:0])
            attributedTextNormal.append(NSAttributedString(string: " "))
            
           
            
            
            attributedTextNormal.append(attributedTextNormalDate)

            messageLabel.attributedText = attributedTextNormal
            messageLabel.sizeToFit()
        }
    }
    
}
struct Message {
    var text: String
    var sendingTime: Date
    var seen: Bool
    var deliveryStatus: DeliveryStatus
    var isSent: Bool
  
}

enum DeliveryStatus: String,CaseIterable {
    case send
    case deliver
    case seen
    case notSent
    
   static func getRandomDeliveryStatus() -> DeliveryStatus {
        let allCases = DeliveryStatus.allCases
        let randomIndex = Int.random(in: 0..<allCases.count)
        return allCases[randomIndex]
    }
}

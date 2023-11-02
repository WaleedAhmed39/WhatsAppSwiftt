//
//  ChatTableViewCell.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 21/06/2023.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var contentSV: UIStackView!
    @IBOutlet weak var fileTypeView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var speakerIV: UIImageView!
    @IBOutlet weak var fileTypeIV: UIImageView!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileIV: UIImageView!
    
    var unSeenCountLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var conversation: Conversations!{
        didSet {
            self.dateLabel.text = conversation.deliveryDate
            self.nameLabel.text = conversation.buddyName
            self.profileIV.image = UIImage(named: conversation.profileImageName)
            self.speakerIV.isHidden = !conversation.isMuted
            self.dateLabel.text = conversation.deliveryDate
            var message = NSAttributedString(string: conversation.lastMessage)
            if conversation.messageType == .audio || conversation.messageType == .image {
                var color:UIColor = .darkGray
                if conversation.isSeen {
                    color = UIColor(named: "ThemeGreenColor")!
                } else {
                    color = .darkGray
                }
                self.fileTypeView.isHidden = false
                self.fileTypeIV.image = (conversation.messageType == .audio ? UIImage(named: "mic_icon") :  UIImage(named: "camera_Icon"))!.withTintColor(color)
            }else if conversation.messageType == .text {
                fileTypeView.isHidden = true
                if self.conversation.isSeen {
                    let seenImage = UIImage(named: "read_check_marker")!.withTintColor(UIColor(named: "ThemeBlueColor")!)
                    
                    let att = NSTextAttachment(image: seenImage)
                    let newMessage = NSMutableAttributedString(attachment: att)
                    newMessage.append(NSAttributedString(string: " "))
                    newMessage.append(message)
                    message = newMessage
                }
            }
            self.lastMessageLabel.attributedText = message
            if conversation.unreadCount > 0  {
                if unSeenCountLabel == nil {
                    unSeenCountLabel = UILabel()
                }
                if let unSeenCountLabel = unSeenCountLabel {
                    if conversation.unreadCount == 1 {
                        unSeenCountLabel.text = "  \(conversation.unreadCount)  "
                    } else  {
                        unSeenCountLabel.text = "  \(conversation.unreadCount)  "
                    }
                    unSeenCountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
                    unSeenCountLabel.setContentHuggingPriority(.required, for: .horizontal)
                    let badgeLabelWidthConstraint = unSeenCountLabel.widthAnchor.constraint(equalToConstant: 0)
                    badgeLabelWidthConstraint.priority = .defaultHigh
                    badgeLabelWidthConstraint.isActive = true
                    unSeenCountLabel.backgroundColor = UIColor(named: "ThemeDarkGreenColor")
                    unSeenCountLabel.clipsToBounds = true
                    unSeenCountLabel.textColor = .white
                    unSeenCountLabel.font = FontFamily.SFProText.Regular.font(size: 12.0)
                    unSeenCountLabel.sizeToFit()
                    unSeenCountLabel.layer.cornerRadius = unSeenCountLabel.frame.height/2
                    unSeenCountLabel.layer.masksToBounds = true
                    let view = UIView(frame: unSeenCountLabel.frame)
                    view.addSubview(unSeenCountLabel)
                    view.translatesAutoresizingMaskIntoConstraints = true
                    view.widthAnchor.constraint(equalTo: unSeenCountLabel.widthAnchor, multiplier: 1).isActive = true
                    view.leadingAnchor.constraint(equalTo:unSeenCountLabel.leadingAnchor , constant: 1).isActive = true
                    view.trailingAnchor.constraint(equalTo: unSeenCountLabel.trailingAnchor, constant: 1).isActive = true
                    unSeenCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                    view.backgroundColor = .clear
                    view.sizeToFit()
                    contentSV.addArrangedSubview(view)
                }
            } else if let unSeenCountLabel = unSeenCountLabel {
               
                contentSV.removeArrangedSubview(unSeenCountLabel.superview!)
                contentSV.layoutIfNeeded()
                unSeenCountLabel.removeFromSuperview()
                self.unSeenCountLabel = nil
                
            }
           
        }
        
        
    }
    
}

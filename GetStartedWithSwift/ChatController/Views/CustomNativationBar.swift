//
//  CustomNativationBar.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import UIKit

class CustomNativationBar: UINavigationBar {

    let kCONTENT_XIB_NAME = "CustomNativationBar"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var selectedCount: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
 
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    
    }
    func makeSingleSelection(showEnableEditFeature:Bool = false){
        profileView.isHidden = true
        videoButton.isHidden = true
        callButton.isHidden = true
        searchButton.isHidden = true
        selectedCount.isHidden = false
        moreButton.isHidden = false
        forwardButton.isHidden = false
        deleteButton.isHidden = false
        infoButton.isHidden = false
        replyButton.isHidden = false
       
        editButton.isHidden = !showEnableEditFeature
        
        
    }
    func makeMultipleSelection(){
        profileView.isHidden = true
        infoButton.isHidden = true
        videoButton.isHidden = true
        searchButton.isHidden = true
        replyButton.isHidden = true
        callButton.isHidden = true
        editButton.isHidden = true
        moreButton.isHidden = true
        selectedCount.isHidden = false
        forwardButton.isHidden = false
        deleteButton.isHidden = false
    }
    func resetNavigation(isGroupChat:Bool){
      
        statusImg.isHidden = isGroupChat
        profileView.isHidden = false
     
        callButton.isHidden = false
        searchButton.isHidden = true
        videoButton.isHidden = isGroupChat
        replyButton.isHidden = true
        infoButton.isHidden = true
        editButton.isHidden = true
        moreButton.isHidden = true
        selectedCount.isHidden = true
        forwardButton.isHidden = true
        deleteButton.isHidden = true
        
    }
    

}

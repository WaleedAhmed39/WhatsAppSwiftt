//
//  StatusViewModel.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 26/6/2023.
//

import Foundation
import UIKit
class StatusViewModel {

    var status:[Status] = [
        Status(buddyName: "My Status", profileImageName: "dummy_user_2" ,  callimage: "plus_icon" , cameraimg: "camera_tab_icon_selected" , editimg: "pencil" , addlabel: "Add to my status"),
        Status(buddyName: "My Status", profileImageName: "dummy_user_2" ,  callimage: "plus_icon" , cameraimg: "camera_tab_icon_selected" , editimg: "pencil" , addlabel: "Add to my status")
    ]
}

struct Status {
    var buddyName:String
    var profileImageName:String
    var callimage:String
    var cameraimg:String
    var editimg:String
    var addlabel:String
}

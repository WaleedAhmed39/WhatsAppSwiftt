//
//  CallViewModel.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 24/6/2023.
//

import Foundation
import UIKit
class CallViewModel {

    var call:[Calls] = [
        Calls(buddyName: "Parker David", deliveryDate: "11/16/19", profileImageName: "dummy_user_1" , callType : .outgoing, callimage: "call_icon_filled", infoimg: "info_icon") ,
        Calls(buddyName: "Lima Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_2", callType : .ingoing , callimage: "call_icon_filled", infoimg: "info_icon") ,
        Calls(buddyName: "Albert Helen", deliveryDate: "11/16/19", profileImageName: "dummy_user_3" ,callType : .video, callimage: "call_icon_filled", infoimg: "info_icon") ,
        Calls(buddyName: "Willford Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_4" ,callType : .outgoing ,callimage: "call_icon_filled" , infoimg: "info_icon") ,
        Calls(buddyName: "Flora Kevin ", deliveryDate: "11/16/19", profileImageName: "dummy_user_5" , callType : .missed , callimage: "call_icon_filled", infoimg: "info_icon"),
        Calls(buddyName: "Willford Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_4" ,callType : .outgoing ,callimage: "call_icon_filled" , infoimg: "info_icon") ,
        Calls(buddyName: "Willford Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_4" ,callType : .outgoing ,callimage: "call_icon_filled" , infoimg: "info_icon") ,
        Calls(buddyName: "Willford Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_4" ,callType : .outgoing ,callimage: "call_icon_filled" , infoimg: "info_icon") ,
        Calls(buddyName: "Willford Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_4" ,callType : .outgoing ,callimage: "call_icon_filled" , infoimg: "info_icon") ,
        Calls(buddyName: "Willford Smith", deliveryDate: "11/16/19", profileImageName: "dummy_user_4" ,callType : .outgoing ,callimage: "call_icon_filled" , infoimg: "info_icon") ,
    ]
}

struct Calls {
    var buddyName:String
    var deliveryDate:String
    var profileImageName:String
    var callType:CallType
    var callimage:String
    var infoimg: String
}
enum CallType {
    case outgoing
    case ingoing
    case video
    case missed
}

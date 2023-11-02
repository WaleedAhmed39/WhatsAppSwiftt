//
//  TabChatViewModel.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//

import Foundation
import UIKit
class TabChatViewModel {
    
    var conversations:[Conversations] = [
        Conversations(buddyName: "Andrew Parker", lastMessage: "What kind of strategy is better?", isMuted: false, deliveryDate: "11/16/19", profileImageName: "dummy_user_1", isSeen: true, messageType: .text),
        Conversations(buddyName: "Karen Castillo", lastMessage: "0:14", isMuted: false, deliveryDate: "11/15/19", profileImageName: "dummy_user_2", isSeen: true, messageType: .audio),
        Conversations(buddyName: "Maximillian Jacobson", lastMessage: "Bro, I have a good idea!", isMuted: false, deliveryDate: "10/30/19", profileImageName: "dummy_user_3", isSeen: true, messageType: .text),
        Conversations(buddyName: "Martha Craig", lastMessage: "Photo", isMuted: false, deliveryDate: "10/30/19", profileImageName: "dummy_user_3", isSeen: true, messageType: .image),
        Conversations(buddyName: "Tabitha Potter", lastMessage: "Actually I wanted to check with you about your online business plan on our…", isMuted: false, deliveryDate: "8/25/19", profileImageName: "dummy_user_4", isSeen: true, messageType: .text),
        Conversations(buddyName: "Maisy Humphrey", lastMessage: "Welcome, to make design process faster, look at Pixsellz", isMuted: false, deliveryDate: "8/20/19", profileImageName: "dummy_user_5", isSeen: true, messageType: .text),
        Conversations(buddyName: "Kieron Dotson", lastMessage: "Ok, have a good trip!", isMuted: true, deliveryDate: "7/29/19", profileImageName: "dummy_user_5", isSeen: true, messageType: .text),
    
    
    
    
    ]
    
    
    
    
    
}

struct Conversations {
    var buddyName:String
    var lastMessage:String
    var isMuted:Bool
    var deliveryDate:String
    var profileImageName:String
    var isSeen:Bool
    var messageType:MessageType
    var unreadCount:Int = Int.random(in: 0...10)
    
    
}
enum MessageType {
    case text
    case image
    case audio
}

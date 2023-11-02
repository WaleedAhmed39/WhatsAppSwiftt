//
//  AccSettingViewModel.swift
//  GetStartedWithSwift
//
//  Created by Waleed Iftikhar on 12/7/2023.
//

import Foundation
class AccSettingViewModel {

    var accsetting:[AccSettings] = [
        AccSettings(SettingName: "Privacy") ,
        AccSettings(SettingName: "Security") ,
        AccSettings(SettingName: "Two-Step Verification") ,
        AccSettings(SettingName: "Change Number") ,
        AccSettings(SettingName: "Request Account Info") ,
       AccSettings(SettingName: "Delete My Account")
    ]
}

struct AccSettings {
    var SettingName:String
}


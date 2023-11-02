//
//  RecorderLockView.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//


import UIKit

extension CGFloat {
    func fromatSecondsFromTimer() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension UIImage{
    
static func fromPod(_ name: String) -> UIImage {
    let traitCollection = UITraitCollection(displayScale: 3)
    let bundle = Bundle.main
    return UIImage(named: name, in: bundle, compatibleWith: traitCollection) ?? UIImage()
    }
}



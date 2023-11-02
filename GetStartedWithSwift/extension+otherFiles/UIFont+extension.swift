//
//  UIFont+extension.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import Foundation
import UIKit


struct FontFamily {
    enum SFProText: String {
        case Regular   = "SFProText-Regular"
        case Light     = "SFProText-Light"
        case Medium    = "SFProText-Medium"
        case Semibold  = "SFProText-Semibold"
        case Bold      = "SFProText-Bold"
        case Heavy     = "SFProText-Heavy"
        
        func font(size: CGFloat) -> UIFont? {
            let font = UIFont(name: self.rawValue, size: size)
            return font
        }
        
        func font(size: CGFloat, weight: CGFloat) -> UIFont {
            var descriptor = UIFontDescriptor(name: self.rawValue, size: size)
            descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: UIFont.Weight(weight)]])
            let font = UIFont(descriptor: descriptor, size: size)
            return font
        }
    }
}

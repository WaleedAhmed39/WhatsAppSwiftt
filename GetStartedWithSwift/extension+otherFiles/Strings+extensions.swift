//
//  Strings+extensions.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 25/06/2023.
//

import Foundation

extension String {
    static func randomString(_ count: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzA BCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        for _ in 0 ..< count {
            let randomIndex = Int(arc4random_uniform(allowedCharsCount))
            let randomCharacter = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomIndex)]
            randomString += String(randomCharacter)
        }
        return randomString
    }
    
    func addSpacingToString(toFitWidth width: CGFloat) -> String {
        let attributedString = NSAttributedString(string: self)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let boundingRect = attributedString.boundingRect(with: size, options: options, context: nil)
        let stringWidth = ceil(boundingRect.width)
        if stringWidth >= width {
            return self
        } else {
            let spacingWidth = width - stringWidth
            let numberOfSpaces = Int(spacingWidth / 4) // Adjust the spacing factor (4) as needed
            
            let spaces = String(repeating: " ", count: numberOfSpaces)
            return self + spaces
        }
    }
    static func createSpacesToFitWidth(_ width: CGFloat) -> String {
        let spaceCharacter = " "
        let attributedString = NSAttributedString(string: spaceCharacter)
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let boundingRect = attributedString.boundingRect(with: size, options: options, context: nil)
        let spaceWidth = ceil(boundingRect.width)
        
        if spaceWidth > 0 {
            let maximumSpaces = Int(width / spaceWidth)
            return String(repeating: " ",count: maximumSpaces)
        } else {
            return String(repeating: " ",count: Int(width))
        }
    }
}

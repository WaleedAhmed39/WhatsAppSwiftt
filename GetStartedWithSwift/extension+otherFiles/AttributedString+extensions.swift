//
//  AttributedString+extensions.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 25/06/2023.
//

import Foundation
extension NSAttributedString {
    var getWidth: CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let boundingRect = self.boundingRect(with: size, options: options, context: nil)
        return ceil(boundingRect.width)
    }
}

//
//  searchBar+extension.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//

import Foundation
import UIKit
extension UISearchController {
    func cancelButton() -> UIButton? {
        if #available(iOS 13.0, *) {
            return findCancelButton13()
        }
        return findCancelButtonOld()
    }

    func findCancelButtonOld() -> UIButton? {
        for subView in searchBar.subviews {
            for v in subView.subviews {
                if let button = v as? UIButton {
                    return button
                }
            }
        }
        return nil
    }

    @available(iOS 13.0, *)
    func findCancelButton13() -> UIButton? {
        for subView in searchBar.subviews {
            for v in subView.subviews {
                for b in v.subviews {
                    if let button = b as? UIButton {
                        return button
                    }
                }
            }
        }
        return nil
    }
}

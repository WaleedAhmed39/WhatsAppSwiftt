//
//
//  RecorderLockView.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//

import UIKit

class iGesutreRecognizer: UIGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard state != .began else {
            return
        }
        state = .began
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }

}

//
//  RecorderLockView.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//

import UIKit

@objc public protocol RecordViewDelegate {
    func onStart()
    func onCancel()
    func onFinished(duration: CGFloat)
    @objc optional func onAnimationEnd()
    @objc optional func onLockRecording()

}

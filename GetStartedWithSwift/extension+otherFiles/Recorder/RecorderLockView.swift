//
//  RecorderLockView.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//

import UIKit
class RecorderLockView: UIView {
    private lazy var lockImageView : LockImageView = {
        
       let image = LockImageView(frame: frame)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var arrowImageView : LockArrowView = {
      let image =  LockArrowView(frame: frame)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func didMoveToSuperview() {
        self.addSubview(lockImageView)
        self.addSubview(arrowImageView)
    }
    override func updateConstraints() {
        lockImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lockImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5).isActive = true
        lockImageView.heightAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5).isActive = true
        lockImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        //arow view
        arrowImageView.topAnchor.constraint(equalTo: self.lockImageView.bottomAnchor, constant: 5).isActive = true
        arrowImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5).isActive = true
        arrowImageView.heightAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5).isActive = true
        arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
//
        super.updateConstraints()
    }
}

class LockImageView : UIImageView , AutoReverseAnimation{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        autoReverseAnimate(view: self)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        self.image = UIImage(named: "ic_lock")
    }
    
}
class LockArrowView : UIImageView, AutoReverseAnimation {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        autoReverseAnimate(view: self)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        
    }
    private func setup() {
        self.image = UIImage(named: "ic_arrow_up_black")
    }
}

protocol AutoReverseAnimation {
    
}
extension AutoReverseAnimation {
    func addAutoReverseAnimation(toView view : UIView, withKey key : String? = nil){
        UIView.animate(withDuration: 0.8,animations: {
            view.frame.origin.y -= 10
            view.isUserInteractionEnabled = true
        }){
            _ in UIView.animateKeyframes(withDuration: 0.8, delay: 00.5, options: [.repeat,.autoreverse,.allowUserInteraction], animations: {
                view.frame.origin.y += 10
                view.isUserInteractionEnabled = true
            })
        }

    }
    func autoReverseAnimate(view : UIView) {
        let option : UIView.AnimationOptions = [.autoreverse,.repeat]
        UIView.animate(withDuration: 1.0, delay: 0, options: option) {
            view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y+2, width: view.frame.width, height: view.frame.height)
        }
    }
}

//
//  RecorderLockView.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 22/06/2023.
//


import UIKit

public class RecordView: UIView, CAAnimationDelegate {
    
    private var isSwipedX = false
    private var isSwipedY = false
    private var needsLock = false
    private var bucketImageView: BucketImageView!
    private var recorderLockView : RecorderLockView!{
        didSet {
            recorderLockView.isHidden = true
        }
    }
    
    private var timer: Timer?
    private var duration: CGFloat = 0
    private var mTransform: CGAffineTransform!
    private var audioPlayer: AudioPlayer!
    private var startIdentity: CGAffineTransform!
    private var timerStackView: UIStackView!
    private var slideToCancelStackVIew: UIStackView!
    
    public weak var delegate: RecordViewDelegate?
    public var offset: CGFloat = 20
    public var isSoundEnabled = true
    public var buttonTransformScale: CGFloat = 2
    private var lastChangedPoint : CGPoint!
    
    public var slideToCancelText: String! {
        didSet {
            slideLabel.text = slideToCancelText
        }
    }
    
    public var slideToCancelTextColor: UIColor! {
        didSet {
            slideLabel.textColor = slideToCancelTextColor
        }
    }
    
    public var slideToCancelArrowImage: UIImage! {
        didSet {
            arrow.image = slideToCancelArrowImage
        }
    }
    
    public var smallMicImage: UIImage! {
        didSet {
            bucketImageView.smallMicImage = smallMicImage
        }
    }
    
    public var durationTimerColor: UIColor! {
        didSet {
            timerLabel.textColor = durationTimerColor
        }
    }
    private let canceButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private let arrow: UIImageView = {
        let arrowView = UIImageView()
        arrowView.image = UIImage.fromPod("ic_leftarrow")
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        arrowView.tintColor = .black
        return arrowView
    }()
    
    private let slideLabel: UILabel = {
        let slide = UILabel()
        slide.text = "Slide To Cancel"
        slide.translatesAutoresizingMaskIntoConstraints = false
        slide.font = slide.font.withSize(12)
        return slide
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setup() {
        bucketImageView = BucketImageView(frame: frame)
        bucketImageView.animationDelegate = self
        bucketImageView.translatesAutoresizingMaskIntoConstraints = false
        bucketImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bucketImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //recorder Lockview
        recorderLockView = RecorderLockView(frame: frame)
        
        
        timerStackView = UIStackView(arrangedSubviews: [bucketImageView, timerLabel])
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        timerStackView.isHidden = true
        timerStackView.spacing = 5
        
        
        slideToCancelStackVIew = UIStackView(arrangedSubviews: [arrow, slideLabel])
        slideToCancelStackVIew.translatesAutoresizingMaskIntoConstraints = false
        slideToCancelStackVIew.isHidden = true
        
        addSubview(canceButton)
        addSubview(timerStackView)
        addSubview(slideToCancelStackVIew)
        addSubview(recorderLockView)
        
        canceButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        canceButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        canceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 10).isActive = true
        canceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        canceButton.isHidden = true
        canceButton.addTarget(self, action: #selector(cancelRecoding), for: .touchUpInside)
        arrow.widthAnchor.constraint(equalToConstant: 15).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        slideToCancelStackVIew.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        slideToCancelStackVIew.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        timerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        timerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        mTransform = CGAffineTransform(scaleX: buttonTransformScale, y: buttonTransformScale)
        
        audioPlayer = AudioPlayer()
    }
    func setUpRecorderLockViewConstraint(from sender : UIView ){
        recorderLockView.translatesAutoresizingMaskIntoConstraints = false
        recorderLockView.bottomAnchor.constraint(equalTo: sender.bottomAnchor, constant: 0).isActive = true
        recorderLockView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        // recorderLockView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        recorderLockView.widthAnchor.constraint(equalTo: sender.widthAnchor,constant: 10).isActive = true
        recorderLockView.trailingAnchor.constraint(equalTo: sender.trailingAnchor, constant: 0).isActive = true
        recorderLockView.layer.cornerRadius = 20
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    func onTouchDown(recordButton: RecordButton) {
        onStart(recordButton: recordButton)
    }
    
    func onTouchUp(recordButton: RecordButton) {
        guard !isSwipedX else {
            return
        }
        onFinish(recordButton: recordButton)
    }
    
    func onTouchCancelled(recordButton: RecordButton) {
        onTouchCancel(recordButton: recordButton)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    @objc func cancelRecoding(){
        isSwipedX = false
        isSwipedY = false
        needsLock = false
        self.audioPlayer.didFinishPlaying = nil
        self.hideCancelStackViewAndTimeLabel()
        self.canceButton.isHidden = true
        self.resetTimer()
        bucketImageView.animateBucketAndMic()
        DispatchQueue.main.asyncAfter(deadline: .now() +  1.7, execute: {
            [weak self] in
            guard let self = self else {return}
            
            self.bucketImageView.isHidden = true
            
            self.delegate?.onAnimationEnd?()
            
            self.delegate?.onCancel()
            
        })
        
    }
    
    @objc private func updateDuration() {
        duration += 1
        timerLabel.text = duration.fromatSecondsFromTimer()
    }
    
    //this will be called when user starts tapping the button
    private func onStart(recordButton: RecordButton) {
        
        isSwipedX = false
        isSwipedY = false
        
        if !needsLock {
            recorderLockView.isHidden = false
            self.prepareToStartRecording(recordButton: recordButton)
            
            if isSoundEnabled {
                audioPlayer.playAudioFile(soundType: .start)
                audioPlayer.didFinishPlaying = { [weak self] _ in
                    self?.delegate?.onStart()
                }
            } else {
                delegate?.onStart()
            }
        }
        else {
            recorderLockView.isHidden = true
            delegate?.onFinished(duration: duration)
            needsLock = false
        }
    }
    
    private func prepareToStartRecording(recordButton: RecordButton) {
        resetTimer()
        
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDuration), userInfo: nil, repeats: true)
        
        
        //reset all views to default
        slideToCancelStackVIew.transform = .identity
        recordButton.transform = .identity
        
        //animate button to scale up
        UIView.animate(withDuration: 0.2) {
            recordButton.transform = self.mTransform
        }
        
        
        slideToCancelStackVIew.isHidden = false
        timerStackView.isHidden = false
        timerLabel.isHidden = false
        bucketImageView.isHidden = false
        bucketImageView.resetAnimations()
        bucketImageView.animateAlpha()
    }
    
    fileprivate func animateRecordButtonToIdentity(_ recordButton: RecordButton) {
        //  DispatchQueue.main.async {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            recordButton.transform = .identity
        },completion: {
            isComleted in
            recordButton.transform = .identity
        })
        // }
        
    }
    
    //this will be called when user swipes to the left and cancel the record
    fileprivate func hideCancelStackViewAndTimeLabel() {
        slideToCancelStackVIew.isHidden = true
        timerLabel.isHidden = true
    }
    
    private func onSwipeX(recordButton: RecordButton) {
        isSwipedX = true
        isSwipedY = true
        audioPlayer.didFinishPlaying = nil
        
        animateRecordButtonToIdentity(recordButton)
        
        hideCancelStackViewAndTimeLabel()
        
        if !isLessThanOneSecond() {
            bucketImageView.animateBucketAndMic()
            
        } else {
            bucketImageView.isHidden = true
            delegate?.onAnimationEnd?()
        }
        
        resetTimer()
        
        delegate?.onCancel()
        
    }
    
    private func onSwipeY(recordButton: RecordButton) {
        isSwipedY = true
        needsLock = true
        recorderLockView.isHidden = true
        
        animateRecordButtonToIdentity(recordButton)
        if !isSwipedX {
            delegate?.onLockRecording?()
        }
    }
    
    private func onTouchCancel(recordButton: RecordButton) {
        isSwipedX = false
        isSwipedY = false
        audioPlayer.didFinishPlaying = nil
        canceButton.isHidden = true
        animateRecordButtonToIdentity(recordButton)
        
        hideCancelStackViewAndTimeLabel()
        
        bucketImageView.isHidden = true
        delegate?.onAnimationEnd?()
        
        resetTimer()
        
        delegate?.onCancel()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timerLabel.text = "00:00"
        duration = 0
    }
    
    //this will be called when user lift his finger
    private func onFinish(recordButton: RecordButton) {
        isSwipedX = false
        isSwipedY  = false
        // if not locked
        if !needsLock {
            canceButton.isHidden = true
            audioPlayer.didFinishPlaying = nil
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                recordButton.transform = .identity
            })
            recorderLockView.isHidden = true
            slideToCancelStackVIew.isHidden = true
            timerStackView.isHidden = true
            
            timerLabel.isHidden = true
            
            
            if isLessThanOneSecond() {
                if isSoundEnabled {
                    audioPlayer.playAudioFile(soundType: .error)
                }
                delegate?.onCancel()
            } else {
                if isSoundEnabled {
                    audioPlayer.playAudioFile(soundType: .end)
                }
                delegate?.onFinished(duration: duration)
            }
            resetTimer()
        }
        else {
            canceButton.isHidden = false
        }
        
        
        
    }
    
    //this will be called when user starts to move his finger
    func touchMoved(recordButton: RecordButton, sender: UIPanGestureRecognizer) {
        let button = sender.view!
        let translation = sender.translation(in: button)
        
        switch sender.state {
        case .changed:
            
            //prevent swiping the button outside the bounds
            if translation.x < 0 && !isSwipedX && !isSwipedY {
                //start move the views
                let transform = mTransform.translatedBy(x: translation.x, y: 0)
                button.transform = transform
                slideToCancelStackVIew.transform = transform.scaledBy(x: 0.5, y: 0.5)
                
                recorderLockView.isHidden = true
                if slideToCancelStackVIew.frame.intersects(timerStackView.frame.offsetBy(dx: offset, dy: 0)) {
                    onSwipeX(recordButton: recordButton)
                }
            }
            else if translation.y < 0 || (!isSwipedY && !isSwipedX) {
                print("swipe upward")
                isSwipedY = true
                let transform = mTransform.translatedBy(x: 0, y: translation.y)
                slideToCancelStackVIew.isHidden = true
                button.transform = transform
                // let location = sender.location(in: self.recorderLockView)
                print(transform)
                if -(transform.ty) >= self.recorderLockView.frame.height/2 {
                    sender.state = .ended
                    onSwipeY(recordButton: recordButton)
                }
            }
        default:
            break
        }
        
    }
    
}


extension RecordView: AnimationFinishedDelegate {
    func animationFinished() {
        slideToCancelStackVIew.isHidden = true
        timerStackView.isHidden = false
        timerLabel.isHidden = true
        delegate?.onAnimationEnd?()
        canceButton.isHidden = true
    }
}

private extension RecordView {
    func isLessThanOneSecond() -> Bool {
        return duration < 1
    }
}




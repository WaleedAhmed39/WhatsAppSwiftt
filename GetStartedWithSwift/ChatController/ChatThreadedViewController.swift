//
//  ChatThreadedViewController.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import UIKit

class ChatThreadedViewController: UIViewController {
    
   
    let customMenuNavigation = CustomNativationBar(frame: .zero)
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var textViewParentHolder: UIView!
    @IBOutlet weak var editorHolderView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var recordingViewHolder: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet  var recordButton: RecordButton!
    private var keyboardHeight: CGFloat = 0.0
    var isRecordingView = false
    var viewModel = ThreadedViewModel()
    lazy var  recordView : RecordView? = {[weak self] in
        guard self != nil else {return nil}
       return RecordView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.customMenuNavigation.titleLbl.text = self.viewModel.conversation.buddyName
        self.customMenuNavigation.subTitleLbl.text = self.viewModel.conversation.deliveryDate
        self.customMenuNavigation.profileImg.image = UIImage(named: self.viewModel.conversation.profileImageName)
        self.setUpRecordingBtn()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
               view.addGestureRecognizer(tapGesture)
        chatTable.delegate = self
        chatTable.dataSource = self
        chatTable.estimatedRowHeight = 35
        chatTable.rowHeight = UITableView.automaticDimension
        chatTable.register(UINib(nibName: "ChatSendTextMessageTVC", bundle: nil), forCellReuseIdentifier: "ChatSendTextMessageTVC")
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
           // Hide the keyboard when clicked outside the TextField
           view.endEditing(true)
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        customMenuNavigation.removeFromSuperview()
        self.navigationItem.setHidesBackButton(false, animated: false)
        unregisterForKeyboardNotifications()
        super.viewWillDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.loadNavigationItems()
        unregisterForKeyboardNotifications()
        registerForKeyboardNotifications()
        super.viewWillAppear(animated)
    }
  
    private func loadNavigationItems(){
        guard let naVC = self.navigationController  else { return }
        naVC.navigationBar.addSubview(customMenuNavigation)
        customMenuNavigation.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        customMenuNavigation.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        customMenuNavigation.bottomAnchor.constraint(equalTo:naVC.navigationBar.bottomAnchor).isActive = true
        customMenuNavigation.leadingAnchor.constraint(equalTo:naVC.navigationBar.leadingAnchor).isActive = true
        customMenuNavigation.trailingAnchor.constraint(equalTo:naVC.navigationBar.trailingAnchor).isActive = true
        customMenuNavigation.detailsButton.addTarget(self, action: #selector(actionTapTitleview), for: .touchUpInside)
        customMenuNavigation.callButton.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
        customMenuNavigation.videoButton.addTarget(self, action: #selector(makeVideoCall), for: .touchUpInside)
        customMenuNavigation.backButton.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        customMenuNavigation.replyButton.addTarget(self, action: #selector(actionReply), for: .touchUpInside)
        customMenuNavigation.forwardButton.addTarget(self, action: #selector(actionMesssageForward), for: .touchUpInside)
        customMenuNavigation.editButton.addTarget(self, action: #selector(actionEdit), for: .touchUpInside)
        customMenuNavigation.moreButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        customMenuNavigation.infoButton.addTarget(self, action: #selector(actionMessageInfo), for: .touchUpInside)
        customMenuNavigation.deleteButton.addTarget(self, action: #selector(actionDeleteMessage), for: .touchUpInside)
        customMenuNavigation.resetNavigation(isGroupChat: false )
    }

    @objc func actionTapTitleview(_ sender: UIButton) {
        
    }
    
    @objc func makeCall(_ sender: UIButton) {
        
    }
    
    @objc func makeVideoCall(_ sender: UIButton) {
        
    }
    
    @objc func actionReply(_ sender: UIButton) {
        
    }
    
    @objc func actionMesssageForward(_ sender: UIButton) {
        
    }
    
    @objc func actionEdit(_ sender: UIButton) {
        
    }
    
    @objc func toggleDropdown(_ sender: UIButton) {
        
    }
    
    @objc func actionMessageInfo(_ sender: UIButton) {
        
    }
    
    @objc func actionDeleteMessage(_ sender: UIButton) {
        
    }
    
    private func setUpRecordingBtn(){
        guard let recordView = recordView else {return}
        recordView.translatesAutoresizingMaskIntoConstraints = false
        recordView.backgroundColor = .white
        recordingViewHolder.addSubview(recordView)
        recordView.trailingAnchor.constraint(equalTo: recordingViewHolder.trailingAnchor).isActive = true
        recordView.leadingAnchor.constraint(equalTo: recordingViewHolder.leadingAnchor).isActive = true
        recordView.topAnchor.constraint(equalTo: recordingViewHolder.topAnchor).isActive = true
        recordView.bottomAnchor.constraint(equalTo: recordingViewHolder.bottomAnchor).isActive = true
        recordButton.recordView = recordView
        recordView.delegate = self
        recordButton.listenForRecord = true
        let text = (textView.text ?? "")
        self.recordButton.isHidden = !(text.isEmpty)
        self.sendButton.isHidden = !self.recordButton.isHidden
        self.view.layoutIfNeeded()
    }
    
    private func updateParentViewHeight() {
        let maxHeight: CGFloat = 200
        let textViewHeight = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height + 5
        let newHeight = min(maxHeight, textViewHeight)
        textViewHeightConstraint.constant = newHeight
        textView.isScrollEnabled = textViewHeight > maxHeight
        let text = (textView.text ?? "")
        self.recordButton.isHidden = !(text.isEmpty)
        self.sendButton.isHidden = !self.recordButton.isHidden
    }
    
    @objc func actionRecorderLongPress(sender : UILongPressGestureRecognizer) {
        
        switch sender.state {
        case .began:
            viewModel.startRecording()
        case .ended :
            viewModel.stopRecording()
        default:
            break
        }
    }
    
    override func keyboardWillAppear(aNotification: Notification) {
        super.keyboardWillAppear(aNotification: aNotification)
        
        let userInfo = aNotification.userInfo
        guard let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let keyboardAppearDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        textViewBottomConstraint.constant = keyboardFrame.height
        keyboardHeight = keyboardFrame.height
        UIView.animate(withDuration: keyboardAppearDuration, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func keyboardWillDisappear(aNotification: Notification) {
        super.keyboardWillDisappear(aNotification: aNotification)
        let userInfo = aNotification.userInfo
        guard let keyboardAppearDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        textViewBottomConstraint.constant = 0
       
        UIView.animate(withDuration: keyboardAppearDuration, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        if isRecordingView {
            recordView?.onTouchDown(recordButton: recordButton)
            self.viewModel.stopRecording()
        }
    }
}

extension ChatThreadedViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateParentViewHeight()
    }
     
}


extension ChatThreadedViewController: RecordViewDelegate {
    func onStart() {
        isRecordingView = true
        self.recordingViewHolder.isHidden = false
        self.textViewParentHolder.isHidden = true
        
        
        self.viewModel.startRecording()
       print("start")
    }
    
    func onCancel() {
        isRecordingView = false
        self.viewModel.cancelRecording()
        print("cancel")
    }
    
    func onFinished(duration: CGFloat) {
        isRecordingView = false
        onAnimationEnd()
        self.viewModel.stopRecording()
    }
    
    func onAnimationEnd() {
        self.recordingViewHolder.isHidden = true
        self.textViewParentHolder.isHidden = false
        
        self.sendButton.isHidden = true
        self.recordButton.isHidden = false
    }
    
    func onLockRecording() {
      
        self.sendButton.isHidden = false
        self.recordButton.isHidden = true
    }
}

extension ChatThreadedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatSendTextMessageTVC", for: indexPath) as! ChatSendTextMessageTVC
        
        
        cell.message = viewModel.messages[indexPath.row]
        
        return cell
    }
    
    
}

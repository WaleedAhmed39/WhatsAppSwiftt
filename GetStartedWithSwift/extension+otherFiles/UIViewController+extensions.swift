//
//  UIViewController+extensions.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import UIKit
import SwiftMessages
extension UIViewController {
    // Toast Message
    func showToast(message: String) {
        view.makeToast(message)
    }
    
    // Show Loader
    func showLoader() {
        SVProgressHUD.show()
    }
    
    // Hide Loader
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
    // Show Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Show SwiftMessages Alert
    func showSwiftMessageAlert(title: String, message: String, layout: MessageView.Layout = .cardView) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(.warning)
        view.configureContent(title: title, body: message)
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
    
    @objc func navigateBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    //    MARK: - UIAlertController Functions
    func showMessage(message:String, withTitle title:String)
    {
        let  vc = UIAlertController(title: nil, message: "PleaseWait", preferredStyle: .alert)
        let indicator:UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(indicator);
        let views:Dictionary<String,UIView> = ["pending": vc.view, "indicator" : indicator];
        let constraintsVertical =   NSLayoutConstraint.constraints(withVisualFormat: "V:[indicator]-(20)-|", options: [], metrics: nil, views: views)
        let  constraintsHorizontal =  NSLayoutConstraint.constraints(withVisualFormat: "H:|[indicator]|" ,options:[], metrics:nil , views:views)
        let constraints =  constraintsVertical + constraintsHorizontal
        vc.view.addConstraints(constraints)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        self.present(vc,animated: true)
    }
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    /**
     Registers the class for listening keyboard notification.
     */
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textInputModeUpdate), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
    }
    
    /**
     Unregisters the class for listening keyboard notification.
     */
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
    }
    
    /**
     Gets called immediately prior to the display of the keyboard.
     - Parameter aNotification: A Notification contains userInfo dictionary, contains information about the keyboard.
     */
    @objc func keyboardWillAppear(aNotification:Notification) {
        
    }
    
    /**
     Gets called immediately prior to the dismissal of the keyboard.
     - Parameter aNotification: A Notification contains userInfo dictionary, contains information about the keyboard.
     */
    @objc func keyboardWillDisappear(aNotification:Notification) {
        
    }
    
    /**
     Gets called after keyboard input mode is updated ( i.e. change from english to emoji or vice versa )
     - Parameter aNotification: A Notification contains userInfo dictionary, contains information about the keyboard.
     */
    @objc func textInputModeUpdate(aNotification:Notification) {
        
    }
    
}
extension UIImage {
    
    func getSizeImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let destImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return destImage
    }
    
    var w20XH20Image : UIImage?{
        let size = CGSize(width: 20,height: 20)
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let destImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return destImage
    }
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
extension UITableView {
    
    func scrollToBottom(isAnimated:Bool = true,bottomOffset offset : CGFloat = 0){
        
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else {
                return
            }
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            guard indexPath.row >= 0 else {return}
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    func scrollToTop(isAnimated:Bool = true) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

extension UIImage {
    func resizeImage( targetSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

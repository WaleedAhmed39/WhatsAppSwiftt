//
//  NeedsBinding.swift
//  WAAFI
//
//  Created by Saifullah Ilyas on 04/11/2021.
//  Copyright © 2021 Safarfone. All rights reserved.
//

import Foundation
import Combine

protocol NeedsBinding : AnyObject  {
    func databinding()
}
protocol SubscriptionStorable  {
    var subscriptions : Set<AnyCancellable>{get set}
    
}
extension SubscriptionStorable {
    func removeAllSubscriptions( object :  NSObject){
        if var mClass = object as? SubscriptionStorable {
            mClass.subscriptions.removeAll()
        }
        
    }
}

 protocol CustomizeNavigationBAR : AnyObject {
}
extension CustomizeNavigationBAR where Self : UIViewController {
    func addNavItem(barItem: UIBarButtonItem , type : BarItemType) {
        
            if type == .left {
                navigationItem.leftBarButtonItem = barItem
            }
            else {
                navigationItem.rightBarButtonItems = [barItem]
            }
       
    }
    func addNavItems(barItems: [UIBarButtonItem] , type : BarItemType) {
            if type == .left {
                navigationItem.leftBarButtonItems = barItems
            }
            else {
                navigationItem.rightBarButtonItems = barItems
            }
        
    }
@discardableResult    func addNavItem(withTitle title : String,andSubTitle subtitle : String)->UIView{
        let container : UIView = UIView(frame: CGRect(x: 70, y: 0, width: 300, height: 44))
        let titleLbl = UILabel(frame: CGRect(x: 0 , y:0 , width:300 , height: 20))
        titleLbl.font = UIFont.boldSystemFont(ofSize: 14)
        titleLbl.textColor = .white
        titleLbl.text = title
        let subTitleLbl = UILabel(frame: CGRect(x: 0, y: 20, width: 350, height: 20))
        subTitleLbl.font = UIFont.systemFont(ofSize: 14)
        subTitleLbl.text = subtitle
        subTitleLbl.textColor = .white
        container.addSubview(titleLbl)
        container.addSubview(subTitleLbl)
       navigationItem.titleView = container
    return container
        
    }
    @discardableResult    func addNavItem(withTitle title : String)->UIView{
            let titleLbl = UILabel(frame: CGRect(x: 0 , y:0 , width:300 , height: 80))
            titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
            titleLbl.textColor = .white
            titleLbl.text = title
           navigationItem.titleView = titleLbl
        return titleLbl
            
        }
    func addNavtitleView(view : UIView) {
        self.navigationItem.titleView = view
    
    }
    func hideNavBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    func showNavbar(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
}
enum BarItemType {
    case left
    case right
}

//
//  CleanType.swift
//  GetStartedWithSwift
//
//  Created by Suleman Ali on 24/06/2023.
//

import Foundation
protocol CleanType {
}
extension CleanType  {
    func runOnMain( closure :@escaping ()->Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
protocol FinishTopViewController {
    
}
extension FinishTopViewController {
    func  finishTopVC(animated anim:Bool = true) {
    if let topVc = UIApplication.topViewController() {
        if topVc.isModal {
            topVc.dismiss(animated: anim, completion: nil)
        }
        else{
            topVc.navigationController?.popViewController(animated: anim)
        }
    }
    }
    
}

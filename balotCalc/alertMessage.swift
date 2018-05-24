//
//  AlertMessage.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/25/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import PCLBlurEffectAlert
import UIKit
class AlertMessage{
    //Custom alert message to confirm a new game
    static func alertMessageDisplay2Actions(title: String?, message: String?, buttonHeight: CGFloat, margin: CGFloat, onAction: @escaping() -> Void){
        let alertMessage = PCLBlurEffectAlert.Controller(title: title, message: message, effect: UIBlurEffect(style: .extraLight), style: .alert)
        
        //Adding an action buttons
        alertMessage.addAction(PCLBlurEffectAlert.Action(title: "لا", style:.cancel, handler: nil))
        alertMessage.addAction(PCLBlurEffectAlert.Action(title: "ايه", style: .default, handler: { (action) in
            onAction()
        }))
        
        //Designing the alert message
        alertMessage.configure(cornerRadius: 20)
        alertMessage.configure(titleColor: UIColor.black)
        alertMessage.configure(messageColor: UIColor.black)
        alertMessage.configure(overlayBackgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4))
        alertMessage.configure(buttonTextColor: [.default: UIColor.blue,
                                                 .destructive: UIColor.blue,
                                                 .cancel: UIColor.blue])
        alertMessage.configure(titleFont: UIFont.systemFont(ofSize: 22))
        alertMessage.configure(messageFont: UIFont.systemFont(ofSize: 24))
        //UIFont(name: "(A) Arslan Wessam A", size: 24)!
        alertMessage.configure(thin: 0.5)
        alertMessage.configure(buttonHeight: buttonHeight)
        alertMessage.configure(margin: margin)
        alertMessage.configure(buttonFont: [.default: UIFont.systemFont(ofSize: 28),
                                            .destructive: UIFont.systemFont(ofSize: 28),
                                            .cancel: UIFont.systemFont(ofSize: 28)])
        alertMessage.show()
    }
    
    static func alertMessageDisplay1Action(title: String?, message: String?, buttonHeight: CGFloat, margin: CGFloat){
        let alertMessage = PCLBlurEffectAlert.Controller(title: title, message: message, effect: UIBlurEffect(style: .extraLight), style: .alert)
        
        //Adding an action buttons
        alertMessage.addAction(PCLBlurEffectAlert.Action(title: "طيب", style:.cancel, handler: nil))
        
        //Designing the alert message
        alertMessage.configure(cornerRadius: 20)
        alertMessage.configure(titleColor: UIColor.black)
        alertMessage.configure(messageColor: UIColor.black)
        alertMessage.configure(overlayBackgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4))
        alertMessage.configure(buttonTextColor: [.default: UIColor.blue,
                                                 .destructive: UIColor.blue,
                                                 .cancel: UIColor.blue])
        alertMessage.configure(titleFont: UIFont.systemFont(ofSize: 22))
        alertMessage.configure(messageFont: UIFont.systemFont(ofSize: 24))
        alertMessage.configure(thin: 0.5)
        alertMessage.configure(buttonHeight: buttonHeight)
        alertMessage.configure(margin: margin)
        alertMessage.configure(buttonFont: [.default: UIFont.systemFont(ofSize: 28),
                                            .destructive: UIFont.systemFont(ofSize: 28),
                                            .cancel: UIFont.systemFont(ofSize: 28)])
        alertMessage.show()
    }
}

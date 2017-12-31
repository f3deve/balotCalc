//
//  handleAboutUsBottons.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 12/30/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit
import MessageUI

extension AboutUSController: MFMailComposeViewControllerDelegate{
    
    //To opne a link
    func openTheLink(urlString: String){
        guard let url = URL(string: urlString) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                if(success){
                    print("open url: \(success)")
                }else{
                    return
                }
            })
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func handleTwitter(){
        openTheLink(urlString: "https://twitter.com/F3Deve")
    }
    
    @objc func handleEmail(){
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Mail services are not available")
            return
        }
    }
    
    func configureMailController() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        mailComposeVC.setToRecipients(["f3deve@gmail.com"])
        
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRateUs(){
        openTheLink(urlString: "https://itunes.apple.com/us/app/%D8%A3%D9%86%D8%B4%D8%B1/id1265043617?mt=8")
    }
    
    
}

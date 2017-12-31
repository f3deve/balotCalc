//
//  AboutUSController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 12/29/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class AboutUSController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var MuneBtn: UIBarButtonItem!
    
    let textFont = UIFont(name: "(A) Arslan Wessam A", size: 26)
    
    lazy var twitterBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "twitterLogo")
        btn.setBackgroundImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(handleTwitter), for: .touchUpInside)
        return btn
    }()
    
    lazy var twitterLabel: UILabel = {
        let label = UILabel()
        label.text = "حسابنا في تويتر"
        label.font = self.textFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var emailBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "EmailLogo")
        btn.setBackgroundImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(handleEmail), for: .touchUpInside)
        return btn
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "لاقتراحات و الاعلانات"
        label.font = self.textFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var rateUsBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "appStoreLogo")
        btn.setBackgroundImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action: #selector(handleRateUs), for: .touchUpInside)
        return btn
    }()
    
    lazy var rateUsLabel: UILabel = {
        let label = UILabel()
        label.text = "قيمّ التطبيق"
        label.font = self.textFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(twitterBtn)
        view.addSubview(twitterLabel)
        
        view.addSubview(emailBtn)
        view.addSubview(emailLabel)
        
        view.addSubview(rateUsBtn)
        view.addSubview(rateUsLabel)
        
        setUpContainerLayout()
        sideMenus()
    }
    
    func setUpContainerLayout(){
        
        //Twitter constrain
        twitterBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        twitterBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twitterBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        twitterBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        twitterLabel.topAnchor.constraint(equalTo: twitterBtn.bottomAnchor, constant: 10).isActive = true
        twitterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Email constrain
        emailBtn.topAnchor.constraint(equalTo: twitterLabel.bottomAnchor, constant: 20).isActive = true
        emailBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        emailBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: emailBtn.bottomAnchor, constant: 10).isActive = true
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Rate us constrain
        rateUsBtn.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20).isActive = true
        rateUsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rateUsBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        rateUsBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        rateUsLabel.topAnchor.constraint(equalTo: rateUsBtn.bottomAnchor, constant: 10).isActive = true
        rateUsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func sideMenus () {
        if revealViewController() != nil {
            MuneBtn.target = revealViewController()
            MuneBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}

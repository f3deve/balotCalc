//
//  LearningPageController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 12/30/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class LearningPageController: UIViewController {
    @IBOutlet weak var MenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
    }
    
    func sideMenus () {
        if revealViewController() != nil {
            MenuBtn.target = revealViewController()
            MenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}

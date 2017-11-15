//
//  CalcViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/14/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class CalcViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ourCurrentCulcScore: UILabel!
    @IBOutlet weak var theirCurrentCulcScore: UILabel!
    @IBOutlet weak var ourTextField: UITextField!
    @IBOutlet weak var theirTextField: UITextField!
    @IBOutlet weak var submitScoreBtnOutlet: UIButton!
    @IBOutlet weak var newGameBtnOutlet: UIButton!
    @IBOutlet weak var ScoresTableView: UITableView!
    
    var ourScoresArray = [String]()
    var theirScoresArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding gusture to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalcViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        ScoresTableView.delegate = self
        ScoresTableView.dataSource = self
        
        //To change the corners of the submit and new game button
        submitScoreBtnOutlet.layer.cornerRadius = 10
        newGameBtnOutlet.layer.cornerRadius = 5
        
        //To move back and forth
        handleTextField()
    }
    
    //To dismiss keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func handleTextField(){
        ourTextField.addTarget(self, action: #selector(CalcViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        theirTextField.addTarget(self, action: #selector(CalcViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        if ( ourTextField.text!.count == 2){
            theirTextField.becomeFirstResponder()
        }
        if ( theirTextField.text!.count == 2){
            ourTextField.becomeFirstResponder()
        }
    }
    
    //To set number of rows of the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ourScoresArray.count;
    }
    
    //To set the content of each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoresTableViewCell
        cell.ourScoresLabel.text = ourScoresArray[indexPath.row]
        cell.theirScoresLabel.text = theirScoresArray[indexPath.row]
        return cell
    }
    
    @IBAction func backBtn(_ sender: Any) {
    }
    
    @IBAction func submitScoreBtn(_ sender: Any) {
    }
    
    @IBAction func newGameBtn(_ sender: Any) {
    }
}

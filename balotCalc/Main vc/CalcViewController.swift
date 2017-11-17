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
    @IBOutlet weak var startAt52outlet: UIBarButtonItem!
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
    
    //Still working on it
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath_1 = IndexPath(row: (self.ourScoresArray.count-1), section: 0)
            let indexPath_2 = IndexPath(row: (self.theirScoresArray.count-1), section: 0)
            self.ScoresTableView.scrollToRow(at: indexPath_1, at: .bottom, animated: true)
            self.ScoresTableView.scrollToRow(at: indexPath_2, at: .bottom, animated: true)
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
    
    //Still working:
    // alert message to confirm and check the current score(if it is more than 100 then this button is disable)
    @IBAction func startAt52(_ sender: Any) {
        if(startAt52outlet.title == "ترصيد"){
            startAt52outlet.title = "بدون ترصيد"
            ourCurrentCulcScore.text = "52"
            theirCurrentCulcScore.text = "52"
        }else{
            startAt52outlet.title = "ترصيد"
            ourCurrentCulcScore.text = "0"
            theirCurrentCulcScore.text = "0"
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        //In case the array is empty to avoid the crash
        if(ourScoresArray.isEmpty && theirScoresArray.isEmpty){ return }
        
        //To get the last element of the array that you want to take off
        let lastOurScoresArray = ourScoresArray.removeLast()
        let lastTheirScoresArray = theirScoresArray.removeLast()
        
        //Update the currnet score for both after deleting the last element
        let total_1 = Int(ourCurrentCulcScore.text!)! - Int(lastOurScoresArray)!
        let total_2 = Int(theirCurrentCulcScore.text!)! - Int(lastTheirScoresArray)!
        ourCurrentCulcScore.text = String(total_1)
        theirCurrentCulcScore.text = String(total_2)
        ScoresTableView.reloadData()
    }
    
    @IBAction func submitScoreBtn(_ sender: Any) {
        //Just to make sure no error when there are no values in the text field
        isItEmpty()
        
        //Adding the new values to the table view
        ourScoresArray.append(ourTextField.text!)
        theirScoresArray.append(theirTextField.text!)
        
        //Update current score along with table view
        updatedValues(textFieldtxt_1: ourTextField.text!, CurrentScoreLabel_1: ourCurrentCulcScore.text!, textFieldtxt_2: theirTextField.text!, CurrentScoreLabel_2: theirCurrentCulcScore.text!)
        ScoresTableView.reloadData()
        ourTextField.text!.removeAll()
        theirTextField.text!.removeAll()
        dismissKeyboard()
        scrollToBottom() //To show the table view from the bottom
    }
    
    /*
     We cannot perform with null value, if we do then it will crach so
     in order to avoid that, we need to make sure there is no null value
     and if so in both of the text fields then we do not perform and if just
     either of them then when out its value to zero
     */
    func isItEmpty(){
        if(ourTextField.text!.isEmpty && theirTextField.text!.isEmpty){ return }
        else if (ourTextField.text!.isEmpty) { ourTextField.text = "0" }
        else if (theirTextField.text!.isEmpty) { theirTextField.text = "0" }
    }
    
    /*
     After we make the conversion and adding them, we need to to update the
     current scores and the table view and removing
     */
    func updatedValues(textFieldtxt_1: String, CurrentScoreLabel_1: String, textFieldtxt_2: String, CurrentScoreLabel_2: String){
        let outTotal: String
        let theirTotal: String
        
        outTotal = calcCurrentScore(textFieldtxt: textFieldtxt_1, CurrentScoreLabel: CurrentScoreLabel_1)
        theirTotal = calcCurrentScore(textFieldtxt: textFieldtxt_2, CurrentScoreLabel: CurrentScoreLabel_2)
        
        ourCurrentCulcScore.text = outTotal
        theirCurrentCulcScore.text = theirTotal
    }
    
    /*
     We cannot add value of type string so in this function:
     - change the text field type and label type to int to add them up
     - then change their total to string to make it the new currentCalcScore label
     */
    func calcCurrentScore(textFieldtxt: String, CurrentScoreLabel: String) -> String {
        let intTextFieldtxt: Int = Int(textFieldtxt)!
        let intCurrentScoreLabel: Int = Int(CurrentScoreLabel)!
        
        let total = intTextFieldtxt + intCurrentScoreLabel
        let totalString: String = String(total)
        return totalString
    }
    
    @IBAction func newGameBtn(_ sender: Any) {
        
    }
}

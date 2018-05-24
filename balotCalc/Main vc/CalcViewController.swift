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

class CalcViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    @IBOutlet weak var ourCurrentCulcScore: UILabel!
    @IBOutlet weak var theirCurrentCulcScore: UILabel!
    @IBOutlet weak var ourTextField: UITextField!
    @IBOutlet weak var theirTextField: UITextField!
    @IBOutlet weak var submitScoreBtnOutlet: UIButton!
    @IBOutlet weak var newGameBtnOutlet: UIButton!
    @IBOutlet weak var startAt52outlet: UIBarButtonItem!
    @IBOutlet weak var ScoresTableView: UITableView!
    @IBOutlet weak var MenuBtn: UIBarButtonItem!
    
    var adView:GADBannerView!
    var ourScoresArray = [String]()
    var theirScoresArray = [String]()
    
    //var isNumber: Bool = true
    
    let winArray = ["مبروك يا وحش 🎉", "مسكتوهم زاوية 😅", "فيه اثنين افضل؟ 🙄", "فوز مستحق 😍"]
    let lostArray = ["خيرها بغيرها", "هاردلك", "الجايات احسن", "وش هالمستوى؟ 😧"]
    let messageArray = ["كرها ما يضرها", "العب مره ثانية ", "خذلك قيم ثاني", "صكة جديدة"]
    
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
        
        //Adding the googleAd
        adView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adView.adUnitID = "ca-app-pub-8760463257793738/6032284835"
        adView.rootViewController = self
        let request = GADRequest()
        adView.load(request)
        adView.frame = CGRect(x: 0, y: view.bounds.height - adView.frame.size.height, width: adView.frame.size.width, height: adView.frame.size.height)
        self.view.addSubview(adView)
        
        //To show the slide menu
        sideMenus ()
    }
    
    //To set number of rows of the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ourScoresArray.count
    }
    
    //To set the content of each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScoresTableViewCell {
            cell.ourScoresLabel.text = ourScoresArray[indexPath.row]
            cell.theirScoresLabel.text = theirScoresArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
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
        guard let ourCurrentCulcScoreTxt = ourCurrentCulcScore.text, let theirCurrentCulcScoreTxt = theirCurrentCulcScore.text else { return }
        
        //In case the array is empty to avoid the crash
        if(ourScoresArray.isEmpty && theirScoresArray.isEmpty){ return }
        
        //To get the last element of the array that you want to take off
        let lastOurScoresArray = ourScoresArray.removeLast()
        let lastTheirScoresArray = theirScoresArray.removeLast()
        
        //Update the currnet score for both after deleting the last element
        if
            let IntOurCurrentCulcScoreTxt = Int(ourCurrentCulcScoreTxt),
            let IntLastOurScoresArray = Int(lastOurScoresArray),
            let IntTheirCurrentCulcScoreTxt = Int(theirCurrentCulcScoreTxt),
            let IntLastTheirScoresArray = Int(lastTheirScoresArray){
            
            let total_1 = IntOurCurrentCulcScoreTxt - IntLastOurScoresArray
            let total_2 = IntTheirCurrentCulcScoreTxt - IntLastTheirScoresArray
            ourCurrentCulcScore.text = String(total_1)
            theirCurrentCulcScore.text = String(total_2)
            ScoresTableView.reloadData()
            
        }
    }
    
    @IBAction func submitScoreBtn(_ sender: Any) {
        guard
            let ourTextFieldTxt = ourTextField.text,
            let theirTextFieldTxt = theirTextField.text,
            let ourCurrentCulcScoreTxt = ourCurrentCulcScore.text,
            let theirCurrentCulcScoreTxt = theirCurrentCulcScore.text
            else { return }
        
        var ourTextfieldReceived: String = ourTextFieldTxt
        var TheirTextfieldReceived: String = theirTextFieldTxt
        
        
        
        /*
         We cannot perform with null value, if we do then it will crach so
         in order to avoid that, we need to make sure there is no null value
         and if so in both of the text fields then we do not perform and if just
         either of them then when out its value to zero
         */
        if(ourTextFieldTxt.isEmpty && theirTextFieldTxt.isEmpty){ return }
        else if (ourTextFieldTxt.isEmpty) { ourTextfieldReceived = "0" }
        else if (theirTextFieldTxt.isEmpty) { TheirTextfieldReceived = "0" }
        
        //If all inputs are number then it will return true
        let isNumber: Bool = (CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: ourTextfieldReceived)) && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: TheirTextfieldReceived)))
        
        // Only works if inputs are numbers
        if isNumber{
            //Adding the new values to the table view
            ourScoresArray.append(ourTextfieldReceived)
            theirScoresArray.append(TheirTextfieldReceived)
            
            //Update current score along with table view
            updatedValues(textFieldtxt_1: ourTextFieldTxt, CurrentScoreLabel_1: ourCurrentCulcScoreTxt, textFieldtxt_2: theirTextFieldTxt, CurrentScoreLabel_2: theirCurrentCulcScoreTxt)
            ScoresTableView.reloadData()
            
            ourTextField.text = ""
            theirTextField.text = ""
            
            dismissKeyboard()
            scrollToBottom() //To show the table view from the bottom
            
            calcThewinner()
        } else {
            AlertMessage.alertMessageDisplay1Action(title: "آدخال خاطئ", message: " ادخال ارقام فقط!", buttonHeight: 50, margin: 10)
            ourTextField.text = ""
            theirTextField.text = ""
        }
        
    }
    
    @IBAction func newGameBtn(_ sender: Any) {
        AlertMessage.alertMessageDisplay2Actions(title: "صكة جديدة 🙄!!", message: "", buttonHeight: 45, margin: 15) {
            self.ourCurrentCulcScore.text = "0"
            self.theirCurrentCulcScore.text = "0"
            self.ourScoresArray.removeAll()
            self.theirScoresArray.removeAll()
            self.ScoresTableView.reloadData()
            self.ourTextField?.text?.removeAll()
            self.theirTextField?.text?.removeAll()
        }
    }
    
    // ----------------------------------------------------------------- //
    //Functions start from here
    
    //To dismiss keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func handleTextField(){
        ourTextField.addTarget(self, action: #selector(CalcViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        theirTextField.addTarget(self, action: #selector(CalcViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    //Moving back and forth between textfields
    @objc func textFieldDidChange(sender: UITextField){
        guard let ourTextfieldTxt = ourTextField.text, let theirTextfieldTxt = theirTextField.text else { return }
        
        if (sender == ourTextField){
            if ourTextfieldTxt.count == 2 && theirTextfieldTxt.isEmpty{
                theirTextField.becomeFirstResponder()
            }
        }
        if (sender == theirTextField){
            if theirTextfieldTxt.count == 2 && ourTextfieldTxt.isEmpty{
                ourTextField.becomeFirstResponder()
            }
        }
    }
    
    //Still working on it
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath_1 = IndexPath(row: (self.ourScoresArray.count - 1), section: 0)
            let indexPath_2 = IndexPath(row: (self.theirScoresArray.count - 1), section: 0)
            self.ScoresTableView.scrollToRow(at: indexPath_1, at: .bottom, animated: true)
            self.ScoresTableView.scrollToRow(at: indexPath_2, at: .bottom, animated: true)
        }
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
        if let intTextFieldtxt: Int = Int(textFieldtxt), let intCurrentScoreLabel: Int = Int(CurrentScoreLabel){
            let total = intTextFieldtxt + intCurrentScoreLabel
            let totalString: String = String(total)
            return totalString
        }
        return "0"
    }
    
    /*
     We need to know who reach the score of 152 or above first to decide who is the winner
     but if both teams reach there at the same time with the same score, then the game is still on
     otherwise, the winner is the one with higher score
     */
    func calcThewinner(){
        guard let ourCurrentCulcScoreTxt = ourCurrentCulcScore.text, let theirCurrentCulcScoreTxt = theirCurrentCulcScore.text else { return }
        
        var titleDisplay: String = ""
        var messageDiplay: String = ""
        
        if let intOurCurrentCulcScore = Int(ourCurrentCulcScoreTxt), let intTheirCurrentCulcScore = Int(theirCurrentCulcScoreTxt){
            if(intOurCurrentCulcScore >= 152 || intTheirCurrentCulcScore >= 152){
                let randomWin = Int(arc4random_uniform(UInt32(winArray.count)))
                let randomLost = Int(arc4random_uniform(UInt32(lostArray.count)))
                let randomMessage = Int(arc4random_uniform(UInt32(lostArray.count)))
                
                if(intOurCurrentCulcScore > intTheirCurrentCulcScore){
                    titleDisplay = winArray[randomWin]
                    messageDiplay = messageArray[randomMessage]
                } else if(intOurCurrentCulcScore == intTheirCurrentCulcScore) {
                    return
                } else {
                    titleDisplay = lostArray[randomLost]
                    messageDiplay = messageArray[randomMessage]
                }
                
                AlertMessage.alertMessageDisplay2Actions(title: titleDisplay, message: messageDiplay, buttonHeight: 50, margin: 10, onAction: {
                    self.ourCurrentCulcScore.text = "0"
                    self.theirCurrentCulcScore.text = "0"
                    self.ourScoresArray.removeAll()
                    self.theirScoresArray.removeAll()
                    self.ScoresTableView.reloadData()
                    self.ourTextField?.text?.removeAll()
                    self.theirTextField?.text?.removeAll()
                })
            }
        }
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adView.isHidden = true
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adView.isHidden = false
    }
    
    //To show the slide menu
    func sideMenus () {
        if revealViewController() != nil {
            MenuBtn.target = revealViewController()
            MenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}

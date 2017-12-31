//
//  HitJViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/24/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit
import PCLBlurEffectAlert
import GoogleMobileAds
import Firebase

class HitJViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, GADBannerViewDelegate {
    @IBOutlet weak var EnterNameTextField: UITextField!
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var MenuBtn: UIBarButtonItem!
    
    var playersArray = [String]()
    var adView:GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersTableView.delegate = self
        playersTableView.dataSource = self
        EnterNameTextField.delegate = self
        
        //To make the saperator line appears only under the tableview entries
        playersTableView.tableFooterView = UIView()
        
        //To change the color of the textField placeholder
        EnterNameTextField.attributedPlaceholder = NSAttributedString(string: EnterNameTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightText])
        
        //Draw a line at the bottom of the text field
        let player_name_layer = CALayer()
        player_name_layer.frame = CGRect(x: 0, y: 33, width: EnterNameTextField.frame.width, height: 1.3)
        player_name_layer.backgroundColor = UIColor(red: 0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        EnterNameTextField.layer.addSublayer(player_name_layer)
        
        //To dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HitJViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //Adding the googleAd
        adView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adView.adUnitID = "ca-app-pub-8760463257793738/6032284835"
        adView.rootViewController = self
        let request = GADRequest()
        adView.load(request)
        adView.frame = CGRect(x: 0, y: view.bounds.height - adView.frame.size.height, width: adView.frame.size.width, height: adView.frame.size.height)
        self.view.addSubview(adView)
        
        //To remove the title of the bar botton
        setCustomBackItem()
        
        //To show the slide menu
        sideMenus ()
    }
    
    //Adding the rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }
    //Adding the content of the rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HitJTableViewCell
        cell.playerLabel.text = "\(indexPath.row + 1). \(playersArray[indexPath.row])"
        return cell
    }
    //To make the row disable to be selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //To enable editing a row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //Porform an action when the row is being editing
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "حذف") { (action, indexPath) in
            self.playersArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return [delete]
    }
    
    //Make the return botton in the keybord act like the add player btn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EnterNameTextField.resignFirstResponder()  //if desired
        proformAction()
        return true
    }
    
    @IBAction func addPlayerBtn(_ sender: Any) {
        proformAction()
    }
    
    //Table view should contain at least four players to do its job
    @IBAction func hitJBtn(_ sender: Any) {
        if(playersArray.count < 4){
            AlertMessage.alertMessageDisplay1Action(title: "", message: "ادخل اربع لاعبين او اكثر", buttonHeight: 45, margin: 15)
        }else{
            performSegue(withIdentifier: "moveToHitJResult", sender: nil)
        }
    }
    
    //-- functions start here --
    //--------------------------
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Adding players to the tableView
    func proformAction(){
        if(EnterNameTextField.text!.isEmpty){
            return
        }
        playersArray.append(EnterNameTextField.text!)
        EnterNameTextField.text!.removeAll()
        playersTableView.reloadData()
    }
    
    //Passing the array information to another controller view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HitJResultViewController
        vc.players_array = playersArray
    }
    
    //To make the back botton with no title
    func setCustomBackItem(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

//
//  HitJResultViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/24/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class HitJResultViewController: UIViewController, GADBannerViewDelegate {
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var player3: UILabel!
    @IBOutlet weak var player4: UILabel!
    @IBOutlet weak var drawCardsLabel: UILabel!
    
    var players_array = [String]()
    var adView:GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random1 = Int(arc4random_uniform(UInt32(players_array.count)))
        player1.text = players_array[random1]
        players_array.remove(at: random1)
        
        let random2 = Int(arc4random_uniform(UInt32(players_array.count)))
        player2.text = players_array[random2]
        players_array.remove(at: random2)
        
        let random3 = Int(arc4random_uniform(UInt32(players_array.count)))
        player3.text = players_array[random3]
        players_array.remove(at: random3)
        
        let random4 = Int(arc4random_uniform(UInt32(players_array.count)))
        player4.text = players_array[random4]
        drawCardsLabel!.text = "التوزيع عند: \(players_array[random4])"
        
        //Adding the googleAd
        adView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adView.adUnitID = "ca-app-pub-8760463257793738/6032284835"
        adView.rootViewController = self
        let request = GADRequest()
        adView.load(request)
        adView.frame = CGRect(x: 0, y: view.bounds.height - adView.frame.size.height, width: adView.frame.size.width, height: adView.frame.size.height)
        self.view.addSubview(adView)
        self.navigationController?.navigationBar.tintColor = UIColor.lightText
    }
    
    @IBAction func playBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalcViewControllerNav")
        self.present(vc!, animated: true, completion: nil)
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adView.isHidden = true
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adView.isHidden = false
    }
}

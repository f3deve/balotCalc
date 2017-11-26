//
//  HitJResultViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/24/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class HitJResultViewController: UIViewController {
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var player3: UILabel!
    @IBOutlet weak var player4: UILabel!
    @IBOutlet weak var drawCardsLabel: UILabel!
    
    var players_array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let random1 = Int(arc4random_uniform(UInt32(players_array.count)))
        player1!.text = players_array[random1]
        players_array.remove(at: random1)
        
        let random2 = Int(arc4random_uniform(UInt32(players_array.count)))
        player2!.text = players_array[random2]
        players_array.remove(at: random2)
        
        let random3 = Int(arc4random_uniform(UInt32(players_array.count)))
        player3!.text = players_array[random3]
        players_array.remove(at: random3)
        
        let random4 = Int(arc4random_uniform(UInt32(players_array.count)))
        player4!.text = players_array[random4]
        drawCardsLabel!.text = "التوزيع عند: \(players_array[random4])"
        
        self.navigationController?.navigationBar.tintColor = UIColor.lightText
    }
    
    @IBAction func playBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalcViewControllerNav")
        self.present(vc!, animated: true, completion: nil)
    }
}

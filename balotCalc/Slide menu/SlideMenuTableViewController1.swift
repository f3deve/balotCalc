//
//  SlideMenuTableViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/26/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class SlideMenuTableViewController1: UITableViewController {
    var slideMenuList = ["Item 1", "Item 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return slideMenuList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SlideMenuTableViewCell
        cell.slideMenuItemLabel.text = slideMenuList[indexPath.row]
        return cell
    }

    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkIndexPath(indexPath: indexPath)
    }*/
    
    func checkIndexPath(indexPath: IndexPath){
        /*switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "moveToMainVC", sender: nil)
        case 1:
            performSegue(withIdentifier: "moveToHitJ", sender: nil)
        default:
            return
        }*/
    }

}

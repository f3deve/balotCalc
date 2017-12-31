//
//  TableViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/27/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var cellsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_\(indexPath.row + 1)", for: indexPath) as! SlideMenuTableViewCell
        cell.cell_1Label.text = cellsArray[indexPath.row]
        return cell
    }
    
    func cellIDforIndexpath(indexPath: IndexPath) -> String{
        var cellId: String = ""
        switch indexPath.row{
        case 0:
            cellId = "cell_1"
        case 1:
            cellId = "cell_2"
        case 2:
            cellId = "cell_3"
        default:
            return ""
        }
        return cellId
    }

}

//
//  SMViewController.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/27/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit


class SMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var listTableView: UITableView!
    var listArray = ["حاسبة بلوت", "دق الولد", "شرح البلوت و الحساب", "من نحن"]
    var imageSample = ["sh1", "d1", "s1", "h1"]
    
    let cellId = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        
        //To add the customize cell
        listTableView.register(SMTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SMTableViewCell {
            cell.listLabel.text = listArray[indexPath.row]
            cell.imageSample.image = UIImage(named: imageSample[indexPath.row])
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = getIdentifier(indexPathRow: indexPath.row)
        
        performSegue(withIdentifier: identifier, sender: nil)
    }
    
    func getIdentifier(indexPathRow: Int) -> String{
        var identifier: String = ""
        if(indexPathRow == 0){
            identifier = "moveToCalcView"
        }else if (indexPathRow == 1){
            identifier = "moveToHitJView"
        }else if (indexPathRow == 2){
            identifier = "moveToLearningPage"
        }else if (indexPathRow == 3){
            identifier = "moveToAboutUsPage"
        }
        return identifier
    }
}

//Cutomize the cell
class SMTableViewCell: UITableViewCell{
    let imageSample: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let listLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 22)
            //UIFont(name: "SC_AMEEN", size: 22)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageSample)
        addSubview(listLabel)
        
        //listLabel.rightAnchor.constraint(equalTo: imageSample.leftAnchor, constant: 10).isActive = true
        listLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        listLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        listLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        listLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageSample.leftAnchor.constraint(equalTo: listLabel.rightAnchor, constant: 10).isActive = true
        imageSample.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageSample.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageSample.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

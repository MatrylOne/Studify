//
//  MeasuresViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import UIKit

class MeasuresViewController: UITableViewController{
    var model:MeasuresModel?
    
    let sections = ["Wzór", "Opis", "Dane", "Pomiary", "Uśredniony pomiar"]
    
    override func viewDidLoad() {
        tableView.allowsSelection = false
        if let model = self.model {
            print("Prawdzowy czas to \(model.realTime)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if model!.checkTimes.count > 0{
            return sections.count
        }else{
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return model?.pattern.descriptors.count ?? 0
        case 2:
            return model?.pattern.constraints.count ?? 0
        case 3:
            return model?.betweenTimes().count ?? 0
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell"),
            let model = self.model else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        switch indexPath.section{
        case 0:
            cell.textLabel?.text = model.pattern.pattern
        case 1:
            cell.textLabel?.text = model.pattern.descriptors[indexPath.row]
        case 2:
            cell.textLabel?.text = model.pattern.constraints[indexPath.row]
        case 3:
            cell.textLabel?.text = "\(model.betweenTimes()[indexPath.row])"
        case 4:
            cell.textLabel?.text = "\(round(model.averageTime() * 100)/100)"
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
}

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
    var model:ExperimentModel?
    
    let sections = ["Wzór", "Opis", "Dane", "Pomiary", "Uśredniony pomiar"]
    
    override func viewDidLoad() {
        tableView.allowsSelection = false
        if let model = self.model {
            print("Prawdzowy czas to \(model.pendulumModel.time)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if model!.stopWatch.count > 0{
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
            return model?.lesson.pattern.descriptors.count ?? 0
        case 2:
            return model?.lesson.pattern.constraints.count ?? 0
        case 3:
            return model?.stopWatch.count ?? 0
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
            cell.textLabel?.text = model.lesson.pattern.pattern
        case 1:
            cell.textLabel?.text = model.lesson.pattern.descriptors[indexPath.row]
        case 2:
            cell.textLabel?.text = model.lesson.pattern.constraints[indexPath.row]
        case 3:
            cell.textLabel?.text = "\(model.stopWatch.betweenTimes[indexPath.row])"
        case 4:
            cell.textLabel?.text = "\(round(model.stopWatch.averageTime * 100)/100)"
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toExam", let controller = segue.destination as? ExamViewController{
            controller.model = self.model
        }
    }
}

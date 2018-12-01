//
//  ExamViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 26/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class ExamFormViewController: UITableViewController {

    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var lengthLabel: UITextField!
    
    var model:ExperimentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
    
    @IBAction func approveTouched(_ sender: UIButton) {
        if isResultOk(result: lengthLabel.text!){
            model?.pendulumResult.lengthInCm = Int(lengthLabel.text!) ?? 0
            
            if isResultOk(result: timeLabel.text!){
                model?.pendulumResult.time = Double(timeLabel.text!) ?? 0
                performSegue(withIdentifier: "toSummary", sender: nil)
            }else{
                print("Błędny okres")
                // TODO: Zrobić allerta
            }
        }else{
            print("Błędna długość")
            // TODO: Zrobić allerta
        }
    }
    
    func isResultOk(result:String) -> Bool{
        // TODO: Sprawdzić poprawność wpisywanych danych
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller =  segue.destination as? ExamGradeViewController{
            controller.model = model
        }else{
            print("zły segue")
        }
    }
    
}

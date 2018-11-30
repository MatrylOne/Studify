//
//  GradeViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 26/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class GradeViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var realTimeLabel: UILabel!
    @IBOutlet weak var calculatedTimeLabel: UILabel!
    @IBOutlet weak var timeErrorLabel: UILabel!
    @IBOutlet weak var realLengthLabel: UILabel!
    @IBOutlet weak var calculatedLengthLabel: UILabel!
    @IBOutlet weak var lengthErrorLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    // MARK: - Model
    var model:ExperimentModel?
    let gradesModel = GradesModel()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        tableView.allowsSelection = false
        
        fillData()
    }
    
    func fillData(){
        guard let results = model?.pendulumResult,
            let reality = model?.pendulumModel else { return }
        
        let roundedTime:Double = round(reality.time * 1000)/1000
        let lengthInCm:Int = reality.lengthInCm
        
        let timeError = 0
        let lengthError = 0
        
        realTimeLabel.text = "\(roundedTime)"
        calculatedTimeLabel.text = "\(results.time)"
        timeErrorLabel.text = "\(timeError)"
        
        realLengthLabel.text = "\(lengthInCm)"
        calculatedLengthLabel.text = "\(results.lengthInCm)"
        lengthErrorLabel.text = "\(lengthError)"
        
        gradeLabel.text = "Will be added in next update"
        
        
        if let model = model{
            _ = Grade(grade: 5,
                      realValue: model.pendulumModel.lengthInCm,
                      userValue: model.pendulumResult.lengthInCm,
                      date: Date(),
                      context: gradesModel.context)
            gradesModel.save()
        }
    }
}

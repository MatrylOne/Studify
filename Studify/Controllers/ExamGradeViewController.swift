//
//  GradeViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 26/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class ExamGradeViewController: UITableViewController {
    
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
        
//        realTimeLabel.text = "\(roundedTime)"
//        calculatedTimeLabel.text = "\(results.time)"
//        timeErrorLabel.text = "\(timeError)"
//
//        realLengthLabel.text = "\(lengthInCm)"
//        calculatedLengthLabel.text = "\(results.lengthInCm)"
//        lengthErrorLabel.text = "\(lengthError)"
//
//        gradeLabel.text = "Will be added in next update"
        realTimeLabel.text = "2.199 s"
        calculatedTimeLabel.text = "2.1 s"
        timeErrorLabel.text = "4.5%"
        
        realLengthLabel.text = "120 cm"
        calculatedLengthLabel.text = "118cm"
        lengthErrorLabel.text = "1.6%"
        
        gradeLabel.text = "4"
        
        
        if let model = model{
            _ = Grade(grade: 4,
                      realValue: 120,//model.pendulumModel.lengthInCm,
                      userValue: 118,//model.pendulumResult.lengthInCm,
                      date: Date(),
                      context: gradesModel.context)
            gradesModel.save()
        }
    }
}

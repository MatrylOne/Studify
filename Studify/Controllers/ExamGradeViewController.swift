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
        
        let roundedTime:Double = Matematical.digits(reality.time, digits: 3)
        let lengthInCm:Int = reality.lengthInCm
        
        let timeError = gradesModel.calculateError(realValue: reality.time, userValue: results.time)
        let lengthError = gradesModel.calculateError(realValue: Double(reality.lengthInCm), userValue: Double(results.lengthInCm))
        
        let grade = gradesModel.calculateGrade(error: lengthError)
        
        realTimeLabel.text = "\(roundedTime)"
        calculatedTimeLabel.text = "\(results.time)"
        timeErrorLabel.text = "\(Matematical.digits(Double(timeError), digits: 3))%"

        realLengthLabel.text = "\(lengthInCm)"
        calculatedLengthLabel.text = "\(Matematical.digits(Double(results.lengthInCm), digits: 3))"
        lengthErrorLabel.text = "\(Matematical.digits(Double(lengthError), digits: 3))%"

        gradeLabel.text = "\(grade)"
        
        if let model = model{
            _ = Grade(grade: grade,
                      realValue: model.pendulumModel.lengthInCm,
                      userValue: model.pendulumResult.lengthInCm,
                      date: Date(),
                      context: gradesModel.context)
            gradesModel.save()
        }
    }
}

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
        let lengthInCm:Double = round(reality.lengthInM * 100)
        
        let timeError = 0
        let lengthError = 0
        
        
        realTimeLabel.text = "\(roundedTime)"
        calculatedTimeLabel.text = "\(results.time)"
        timeErrorLabel.text = "\(timeError)"
        
        realLengthLabel.text = "\(lengthInCm)"
        calculatedLengthLabel.text = "\(results.length)"
        lengthErrorLabel.text = "\(lengthError)"
        
        gradeLabel.text = "Will be added in next update"
        
        
        if let model = model{
            _ = Grade(grade: 5,
                      realValue: Int(round(model.pendulumModel.lengthInM * 100)),
                      userValue: Int(round(model.pendulumResult.length * 100)),
                      date: Date(),
                      context: model.context)
            do{
                try model.context.save()
            }catch {
                print(error)
            }
        }
    }
}

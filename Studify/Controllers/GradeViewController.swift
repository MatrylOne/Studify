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
        let timeError = (roundedTime / abs(roundedTime - results.time)) * 100
        let roundedTimeError = round(timeError * 1000)/1000
        
        let lengthInCm:Double = round(reality.length * 100)
        let roundedLengthError = round(((lengthInCm) / abs((lengthInCm) - results.length)) * 100 * 1000)/1000
        
        realTimeLabel.text = "\(roundedTime)"
        calculatedTimeLabel.text = "\(results.time)"
        timeErrorLabel.text = "\(roundedTimeError)"
        
        realLengthLabel.text = "\(lengthInCm)"
        calculatedLengthLabel.text = "\(results.length)"
        lengthErrorLabel.text = "\(roundedLengthError)"
        
        gradeLabel.text = "Will be added in next update"
    }
}

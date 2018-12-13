//
//  GradeDetailViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 28/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class GradeDetailViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var realValueLabel: UILabel!
    @IBOutlet weak var userValueLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Model
    var model:Grade?
    var gradesModel = GradesModel()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        fill()
    }
    
    func fill(){
        guard let model = model else {return}
        let dateFormater = DateFormatter()
        let error = gradesModel.calculateError(realValue: Double(model.realValue), userValue: Double(model.userValue))
        dateFormater.dateFormat = "dd.MM.yyyy"
        dateLabel.text = "\(dateFormater.string(from: model.date!))"
        gradeLabel.text = "\(model.grade)"
        realValueLabel.text = "\(model.realValue)"
        userValueLabel.text = "\(model.userValue)"
        errorLabel.text = "\(Matematical.digits(error, digits: 3))%"
    }
}

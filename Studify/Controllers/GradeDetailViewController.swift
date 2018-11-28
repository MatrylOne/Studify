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
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
}

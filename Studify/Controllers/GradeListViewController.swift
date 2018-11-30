//
//  GradeListViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 28/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit
import CoreData

class GradeListViewController: UITableViewController {
    // MARK: - Model
    let model = GradesModel()
    
    // MARK: - Properties
    var selectedModel = 0
    
    // Mark: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    @IBAction func clearTouched(_ sender: UIBarButtonItem) {
        model.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    // TODO: Removing grades
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.lessons.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.grades().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let grade = model.grades()[indexPath.row]
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        
        cell.textLabel?.text = "\(dateFormater.string(from:grade.date!))"
        cell.detailTextLabel?.text = "\(grade.grade)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.lessons[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedModel = indexPath.row
        performSegue(withIdentifier: "toGradeDetail", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GradeDetailViewController{
            controller.model = model.grades()[selectedModel]
        }
    }
}

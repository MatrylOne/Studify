//
//  LessonDetailViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 15/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class LessonDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var runButton: BigCoverButton!
    
    // MARK: - Class properties
    var model:ExperimentModel?
    
    // MARK: - Class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lessonModel = model?.lesson{
            title = lessonModel.name
            runButton.setImage(UIImage(named: lessonModel.imageName), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let model = model, let controller = segue.destination as? ARExperimentViewController{
            controller.model = model
        }
    }
}

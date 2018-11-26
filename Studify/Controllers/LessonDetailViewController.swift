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
    var model:Lesson?
    
    // MARK: - Class methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = model{
            title = model.name
            runButton.setImage(UIImage(named: model.image), for: .normal)
        }
    }
}

//
//  LessonDetailViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 15/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class LessonDetailViewController: UIViewController {
    
    var model:Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = model{
            title = model.name
        }
    }
    
    @IBAction func runAR(_ sender: Any) {
        performSegue(withIdentifier: "ARSegue", sender: self)
    }
    
}

//
//  ExamViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 23/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var model:MeasuresModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func acceptTouched(_ sender: UIButton) {
        print("Dobra długość : \(model!.realLength), twoja długość \(textField.text)")
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

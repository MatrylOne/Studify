//
//  MeasuresModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ExperimentModel{
    
    // MARK: - Connected objects
    let stopWatch = Stopwatch()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Class properties
    var pendulumModel = PendulumModel()
    var pendulumResult = PendulumResult()
    var lesson:Lesson
    
    init(lesson:Lesson) {
        self.lesson = lesson
    }
}

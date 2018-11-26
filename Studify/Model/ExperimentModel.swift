//
//  MeasuresModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class ExperimentModel{
    
    // MARK: - Connected objects
    let stopWatch = Stopwatch()
    
    // MARK: - Class properties
    var pendulumModel = PendulumModel()
    var lesson:Lesson
    
    init(lesson:Lesson) {
        self.lesson = lesson
    }
}

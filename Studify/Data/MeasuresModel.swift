//
//  MeasuresModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class MeasuresModel{
    var checkTimes: [Int] = []
    let pattern: PatternModel
    
    init(pattern: PatternModel){
        self.pattern = pattern
    }
}

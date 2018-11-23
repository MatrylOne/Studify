//
//  MeasuresModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class MeasuresModel{
    var checkTimes: [DispatchTime] = []
    let pattern: Pattern
    
    init(pattern: Pattern){
        self.pattern = pattern
    }
}

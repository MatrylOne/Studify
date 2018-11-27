//
//  PatternModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class Pattern{
    let pattern:String
    var descriptors: [String] = []
    var constraints: [String] = []
    
    init(_ pattern:String, descriptors:[String], constraints: [String]){
        self.pattern = pattern
        self.descriptors = descriptors
        self.constraints = constraints
    }
    
}

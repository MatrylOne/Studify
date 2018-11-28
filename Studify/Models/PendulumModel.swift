//
//  PendulumModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 26/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class PendulumModel{
    // MARK: - Properties
    let lengthInM:Double
    
    // MARK: - Computed properties
    lazy var time:Double = {
        return 2 * Double.pi * sqrt(lengthInM/Settings.Physics.gVelocity)
    }()
    
    // MARK: - Methods
    init(){
        let minHeight = Settings.Pendulum.minHeight
        let maxHeight = Settings.Pendulum.maxHeight
        
        // Random length
        lengthInM = Double(arc4random_uniform(maxHeight - minHeight) + minHeight)/100
    }
    
    init(lengthInM:Double){
        self.lengthInM = lengthInM
    }
}

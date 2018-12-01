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
    let lengthInCm:Int
    
    // MARK: - Computed properties
    lazy var time:Double = {
        return 2 * Double.pi * sqrt((Double(lengthInCm) / 100)/Settings.PhysicsSettings.gVelocity)
    }()
    
    // MARK: - Methods
    init(){
        let minHeight = Settings.PendulumSettings.minHeight
        let maxHeight = Settings.PendulumSettings.maxHeight
        
        // Random length
        lengthInCm = Int(arc4random_uniform(maxHeight - minHeight) + minHeight)
    }
    
    init(lengthInCm:Int){
        self.lengthInCm = lengthInCm
    }
}

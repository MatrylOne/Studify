//
//  Settings.swift
//  Studify
//
//  Created by Jakub Nadolny on 08/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import SceneKit

public class Settings{
    public class FocusSquare{
        
    }
    
    public class Pendulum{
        static let minHeight: UInt32 = 15
        static let maxHeight: UInt32 = 120
        
        static let angle: CGFloat = .pi/80
        
        static let ballSize = CGFloat(0.02)
        static let checkerHeight = 0.002
        static let basePlateHeight = 0.1
        static let frameThickness = CGFloat(0.005)
    }
}

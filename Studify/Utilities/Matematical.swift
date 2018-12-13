//
//  Matematical.swift
//  Studify
//
//  Created by Jakub Nadolny on 13/12/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class Matematical{
    static func digits(_ value:Double, digits:Double) -> Double{
        let multiply = pow(10, digits)
        return round(value * multiply)/multiply
    }
}

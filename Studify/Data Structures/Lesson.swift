//
//  Lesson.swift
//  Studify
//
//  Created by Jakub Nadolny on 15/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import UIKit

struct Lesson{
    let id:Int
    let name:String
    let description:String
    let instruction:String
    let imageName:String
    let pattern:Pattern
}

extension Lesson:Equatable{
    public static func == (lhs: Lesson, rhs: Lesson) -> Bool{
        let idEqual = lhs.id == rhs.id
        let nameEqual = lhs.name == rhs.name
        let descriptiopnEqual = lhs.description == rhs.description
        let instructionEqual = lhs.instruction == rhs.instruction
        let imageEqual = lhs.imageName == rhs.imageName
        let patternEqual = lhs.pattern == rhs.pattern
        return idEqual && nameEqual && descriptiopnEqual && instructionEqual && imageEqual && patternEqual
    }
}

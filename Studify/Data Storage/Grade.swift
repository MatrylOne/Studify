//
//  Grade.swift
//  Studify
//
//  Created by Jakub Nadolny on 28/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import CoreData

extension Grade{
    convenience init(grade:Int, realValue:Int, userValue:Int, date:Date, context:NSManagedObjectContext){
        self.init(context: context)
        self.grade = Int16(grade)
        self.realValue = Int16(realValue)
        self.userValue = Int16(userValue)
        self.date = date
    }
}

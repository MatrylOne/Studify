//
//  GradesModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 28/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GradesModel{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let lessons = DataStorage.LessonsData.lessons
    lazy var grades:[Grade] = {
        let gradesRequest = NSFetchRequest<Grade>(entityName: "Grade")
        do{
            if let results = try context.fetch(gradesRequest) as? [Grade]{
                return results
            }
        }catch{
            print(error)
        }
        return []
    }()
}

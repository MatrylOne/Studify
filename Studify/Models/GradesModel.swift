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
    var context = {return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext}()
    let lessons = DataStorage.LessonsData.lessons
    
    func getAllGrades() -> [Grade]{
        let gradesRequest = NSFetchRequest<Grade>(entityName: "Grade")
        do{
            let results = try context.fetch(gradesRequest)
            return results
        }catch{
            print(error)
        }
        return []
    }
    
    func remove(grade:Grade){
        context.delete(grade)
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func removeAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Grade")
        let batchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(batchRequest)
        }catch{
            print(error)
        }
    }
    
    func save(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func calculateError(realValue:Double, userValue:Double) -> Double{
        return 100 * abs(realValue - userValue)/realValue
    }
    
    func calculateGrade(error:Double) -> Int{
        if error < 2{
            return 5
        } else if error < 4{
            return 5
        } else if error < 6{
            return 4
        } else if error < 8{
            return 4
        } else if error < 10{
            return 3
        } else if error < 12{
            return 3
        } else if error < 14{
            return 2
        } else if error < 16 {
            return 2
        } else {
            return 1
        }
    }
}

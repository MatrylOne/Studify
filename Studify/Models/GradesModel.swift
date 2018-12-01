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
}

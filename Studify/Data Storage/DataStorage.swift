//
//  DataStorage.swift
//  Studify
//
//  Created by Jakub Nadolny on 28/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class DataStorage{
    public class PatternsData{
        static let pendulum = Pattern("T = 2 * PI * sqrt(l/g)",
                                      descriptors: ["T - Okres wahadła",
                                                    "l - Długośc linki wahadła",
                                                    "g - Stałą przyspieszenia grawitacyjnego"],
                                      
                                      constraints: ["PI - 3.14",
                                                    "g - 9.89"])
    }
    
    public class LessonsData{
        static let lessons = [Lesson(id: 1,
                                     name: "Ruch harmoniczny",
                                     description: "Lekcja o ruchu harmonicznym",
                                     instruction: "Rusz wahadłem",
                                     image:"gravity",
                                     pattern:DataStorage.PatternsData.pendulum)]
    }
}

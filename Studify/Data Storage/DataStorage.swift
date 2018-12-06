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
        static let pendulumPattern = Pattern("T = 2 * PI * sqrt(l/g)",
                                      descriptors: ["T - Okres wahadła",
                                                    "l - Długośc linki wahadła",
                                                    "g - Stałą przyspieszenia grawitacyjnego"],
                                      
                                      constraints: ["PI - 3.14",
                                                    "g - 9.89"])
    }
    
    public class LessonsData{
        static let lessons = [Lesson(id: 1,
                                     name: "Ruch harmoniczny",
                                     description: "Zeskanuj płaszczyznę i dodaj wirtualne wahadło. Aby dodać wahadło, dotknij ekranu po pojawieniu się kursora. Zbadaj okres wahadła, a następnie użyj danego wzoru do obliczenia jego wysokości. Wahadło można obracać przesuwając dwoma palcami po ekranie. Użyj przycisku timer aby zbierać wiele pomiarów czasowych. Zebrane pomiary posłużą do ustalenia okresu wahadła. Po zebraniu wystarczającej liczby pomiarów dotknij przycisku wyniki. Aby rozpocząć eksperyment dotknij przycisku rozpocznij.",
                                     instruction: "Rusz wahadłem",
                                     imageName:"gravity",
                                     pattern:DataStorage.PatternsData.pendulumPattern)]
    }
}

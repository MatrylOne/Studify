//
//  ExperimentModelTests.swift
//  StudifyTests
//
//  Created by Jakub Nadolny on 30/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import XCTest
@testable import Studify

class ExperimentModelTests: XCTestCase {

    var model:ExperimentModel!
    let lesson = DataStorage.LessonsData.lessons.first!
    
    override func setUp() {
        model = ExperimentModel(lesson: lesson)
    }

    override func tearDown() {
        model = nil
    }
    
    func testLesson(){
        XCTAssertEqual(model.lesson, lesson)
    }
}

//
//  PendulumModelTests.swift
//  StudifyTests
//
//  Created by Jakub Nadolny on 30/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import XCTest
@testable import Studify

class PendulumModelTests: XCTestCase {

    var model:PendulumModel!
    let length = 120
    
    override func setUp() {
        model = PendulumModel(lengthInCm: length)
    }

    override func tearDown() {
        model = nil
    }
    
    func testLength(){
        XCTAssertEqual(model.lengthInCm, length)
    }
    
    func testTime(){
        // source https://www.wolframalpha.com/input/?i=T+%3D+2+*+PI+*+sqrt(1.20%2F9.8)
        // l = 120 cm = 1.2 m
        // g = 9.8 stored at Settings.PhysicsSettings.gVelocity
        // T = 2 * PI * sqrt(l/g)
        let timeFor120cm = 2.199
        XCTAssertEqual(model.time, timeFor120cm, accuracy: 0.001)
    }

}

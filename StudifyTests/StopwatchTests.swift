//
//  StopwatchTests.swift
//  StudifyTests
//
//  Created by Jakub Nadolny on 29/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import XCTest
@testable import Studify

class StopwatchTests: XCTestCase {

    var stopwatch:Stopwatch!
    
    override func setUp() {
        stopwatch = Stopwatch()
    }

    override func tearDown() {
        stopwatch = nil
    }
    
    func testCheck(){
        let iterations = 10
        fillWithAverage(time: 0, checks: iterations)
        XCTAssertEqual(stopwatch.count, iterations - 1)
    }
    
    func testAverage(){
        let iterations = 3
        let delay = 2
        fillWithAverage(time: delay, checks: iterations)
        XCTAssertEqual(stopwatch.averageTime, Double(delay), accuracy: 0.01)
    }
    
    // MARK: - Helper functions
    func fillWithAverage(time:Int, checks:Int){
        for _ in 0..<checks{
            stopwatch.addTime()
            sleep(UInt32(time))
        }
    }
}

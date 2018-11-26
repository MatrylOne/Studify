//
//  Stopwatch.swift
//  Studify
//
//  Created by Jakub Nadolny on 26/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class Stopwatch{
    // MARK: - Properties
    private var checkTimes: [DispatchTime] = []
    
    // MARK: - Computed properties
    lazy var betweenTimes:[Double] = {
        var times:[Double] = []
        if checkTimes.count > 1{
            for i in 0..<checkTimes.count-1{
                let firstTime = checkTimes[i].uptimeNanoseconds
                let secondTime = checkTimes[i+1].uptimeNanoseconds
                let between = secondTime.subtractingReportingOverflow(firstTime)
                times.append(Double(between.partialValue))
            }
            times = times.map{round($0 * 0.000000001 * 1000)/1000}
        }
        return times
    }()
    
    lazy var averageTime:Double = {
        return betweenTimes.reduce(0, {$0 + $1})/Double(betweenTimes.count)
    }()
    
    lazy var count:Int = {
        return betweenTimes.count
    }()
    
    // MARK: - Methods
    func check(){
        checkTimes.append(DispatchTime.now())
    }
}

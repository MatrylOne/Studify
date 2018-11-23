//
//  MeasuresModel.swift
//  Studify
//
//  Created by Jakub Nadolny on 09/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation

class MeasuresModel{
    var checkTimes: [DispatchTime] = []
    let pattern: Pattern
    var realTime:Double = 0
    var realLength:Double = 0
    
    init(pattern: Pattern){
        self.pattern = pattern
    }
    
    func betweenTimes() -> [Double]{
        var times:[UInt64] = []
        
        for i in 0..<checkTimes.count-1{
            let firstTime = checkTimes[i].uptimeNanoseconds
            let secondTime = checkTimes[i+1].uptimeNanoseconds
            let between = secondTime.subtractingReportingOverflow(firstTime)
            times.append(between.partialValue)
            
        }
        return times.map{round(Double($0) * 0.000000001 * 1000)/1000}
    }
    
    func averageTime() -> Double{
        return betweenTimes().reduce(0, {$0 + $1})/Double(betweenTimes().count)
    }
}

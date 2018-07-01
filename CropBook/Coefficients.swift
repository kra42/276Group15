//
//  Coefficients.swift
//  TestLibrary
//
//  Created by Bowen He on 2018-06-30.
//  Copyright © 2018 Bowen He. All rights reserved.
//

import Foundation

class Coefficients{
    var initial : Double
    var mid : Double
    var end : Double
    
    init(initial:Double,mid:Double,end:Double) {
        self.initial = initial
        self.mid = mid
        self.end = end
    }
    
    init(json:[String:Double]){
        self.initial = json["init"] ?? 0
        self.mid = json["mid"] ?? 0
        self.end = json["end"] ?? 0
    }
    
    func getInitial() -> Double{
        return initial
    }
    
    func getMid() -> Double{
        return mid
    }
    
    func getEnd() -> Double{
        return end
    }
    
    func printData(){
        print(initial)
        print(mid)
        print(end)
    }
}


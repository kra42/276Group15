//
//  Coefficients.swift
//  TestLibrary
//
//  Created by Bowen He on 2018-06-30.
//  Copyright © 2018 Bowen He. All rights reserved.
//

import Foundation

class Coefficients{
    var initial : Float
    var mid : Float
    var end : Float
    
    init(initial:Float,mid:Float,end:Float) {
        self.initial = initial
        self.mid = mid
        self.end = end
    }
    
    init(json:[String:Double]){
        self.initial = Float(json["init"] ?? 0)
        self.mid = Float(json["mid"] ?? 0)
        self.end = Float(json["end"] ?? 0)
    }
    
    func getInitial() -> Float{
        return initial
    }
    
    func getMid() -> Float{
        return mid
    }
    
    func getEnd() -> Float{
        return end
    }
    
    func getString() -> String{
        let str1 = "Initial Growth: " + String(initial)
        let str2 = str1 + " Mid Growth: " + String(mid)
        let str3 = str2 + " End Growth: " + String(end)
        return str3
    }
    
    func printData(){
        print(initial)
        print(mid)
        print(end)
    }
}


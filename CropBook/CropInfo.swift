//
//  CropInfo.swift
//  TestLibrary
//
//  Created by Bowen He on 2018-06-30.
//  Copyright © 2018 Bowen He. All rights reserved.
//

import Foundation
import UIKit

class CropInfo{
    
    let cropName : String;
    let coEff : Coefficients;
    let cropType : String;
    let image : String;
    let sunExposure : String;
    let soilType : String;
    let soilpH : String;
    let plantCare : String;
    let plantFeeding : String;
    let plantSpacing : String;
    let plantNotes : String;
    let plantHarvesting : String;
 
    init(){
        self.cropName = ""
        self.coEff = Coefficients(initial: 0, mid: 0, end: 0)
        self.cropType = ""
        self.image = ""
        self.sunExposure = ""
        self.soilType = ""
        self.soilpH = ""
        self.plantCare = ""
        self.plantFeeding = ""
        self.plantSpacing = ""
        self.plantNotes = ""
        self.plantHarvesting = ""
        
    }
    
    init(json:[String: Any],coEff:Coefficients) {
        self.cropName = json["cropName"] as? String ?? ""
        self.coEff = coEff
        self.cropType = json["Type"] as? String ?? ""
        self.image = json["Image"] as? String ?? ""
        self.sunExposure = json["sunExposure"] as? String ?? ""
        self.soilType = json["soilType"] as? String ?? ""
        self.soilpH = json["soilpH"] as? String ?? ""
        self.plantCare = json["plant"] as? String ?? ""
        self.plantFeeding = json["feeding"] as? String ?? ""
        self.plantSpacing = json["spacing"] as? String ?? ""
        self.plantNotes = json["notes"] as? String ?? ""
        self.plantHarvesting = json["harvesting"] as? String ?? ""
    }
    
    func getName() -> String{
        return self.cropName
    }
    
    func getType() -> String{
        return self.cropType
    }
    
    func getCoEff() -> Coefficients{
        return self.coEff
    }
    
    
    func getImage() -> String{
        return image
    }
    
    
    func getSunExposure() -> String{
        return self.sunExposure
    }
    
    func getSoilType() -> String{
        return self.soilType
    }
    
    func getSoilpH() -> String{
        return self.soilpH
    }
    
    func getCare() -> String{
        return self.plantCare
    }
    
    func getFeeding() -> String{
        return self.plantFeeding
    }
    
    func getSpacing() -> String{
        return self.plantSpacing
    }
    
    func getNotes() -> String{
        return self.plantNotes
    }
    
    func getHarvesting() -> String{
        return self.plantHarvesting
    }
    
    func isSameCrop(matchCrop: String) -> Bool{
        return cropName.lowercased() == matchCrop.lowercased()
    }
    
    func isSameType(matchType: String) -> Bool{
        return cropType.lowercased() == matchType.lowercased()
    }
    
    func printData(){
        print(cropName + "\n" + cropType)
        coEff.printData()
        print(image + "\n" + sunExposure)
        print(soilType + "\n" + soilpH)
        print()
    }
}

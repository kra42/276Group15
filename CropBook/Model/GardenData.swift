//
//  GardenData.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-15.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import Foundation

class GardenData{
    var gardenId : String
    var userRole : String
    
    init(){
        self.gardenId = ""
        self.userRole = ""
        
    }
    init(gardenId : String, userRole : String){
        self.gardenId = gardenId
        self.userRole = userRole
    }
    
    func getGardenId() -> String{
        return self.gardenId
    }
    
    func getUserRole() -> String{
        return self.userRole
    }
}

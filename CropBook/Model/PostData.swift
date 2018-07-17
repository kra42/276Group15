//
//  GardenData.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-15.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import Foundation

class PostData{
    var postId : String
    var postTitle : String
    
    init(){
        self.postId = ""
        self.postTitle = ""
        
    }
    init(postId  : String, postTitle : String){
        self.postId = postId
        self.postTitle = postTitle
    }
    
    func getGardenId() -> String{
        return self.postId
    }
    
    func getUserRole() -> String{
        return self.postTitle
    }
}

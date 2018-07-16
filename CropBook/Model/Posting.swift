//
//  Posting.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-15.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import Foundation

class Posting{
    var postTitle : String
    //var postDescription : String
    
    /*
    init(postTitle : String, postDescription : String){
        self.postTitle = postTitle
        self.postDescription = postDescription
    }
    */
    
    init(){
        self.postTitle = ""
    }
    //testing purposes
    init(postTitle : String){
        self.postTitle = postTitle
    }
    
    func getTitle() -> String{
        return self.postTitle
    }
    
    /*
    func getDescription() -> String{
        return self.postDescription
    }
    */
    
}

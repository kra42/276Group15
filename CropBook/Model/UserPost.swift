//
//  UserPost.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-18.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import Foundation

class UserPost{
    
    var postId : String
    var isOwner : Bool
    
    init(postId : String, isOwner : Bool){
        self.postId = postId
        self.isOwner = isOwner
    }
    
    func getId() -> String{
        return self.postId
    }
    
    func isTheOwner() -> Bool{
        return self.isOwner
    }
    
}

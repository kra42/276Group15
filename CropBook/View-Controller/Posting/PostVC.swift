//
//  PostVC.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-15.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PostVC: UIViewController {

    var post : Posting = Posting()
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.text = post.getDescription()
        descriptionField.isEditable = false
        postTitle.text = post.getTitle()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

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

    var post : GardenData = GardenData()
    var gardenRef : DatabaseReference?
    @IBOutlet weak var postTitle: UILabel!
    
    override func viewDidLoad() {
        gardenRef = Database.database().reference()
        gardenRef?.child("Gardens").child(post.gardenId).child("Crops").observe(.childAdded, with: { (gardenSnapshot) in
            let printId = gardenSnapshot.key as? String
            print(printId)
        })
        
        postTitle.text = post.getGardenId()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

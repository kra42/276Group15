//
//  FirstViewController.swift
//  CropBook
//
//  Created by jon on 2018-06-28.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import Firebase

//var GardenList=[MyGarden?]()
class MyGardenController: UIViewController {
    
    //var ref: DatabaseReference!
    
    //ref = Database.database().reference()
    
    override func viewDidLoad() {
        
        self.navigationController?.popViewController(animated: true)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Page 1 Loaded")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    @IBAction func unwindGardens(segue: UIStoryboardSegue){
        self.navigationController?.popViewController(animated: true)
    }


}


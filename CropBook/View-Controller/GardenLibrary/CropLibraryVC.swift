//
//  SecondViewController.swift
//  CropBook
//
//  Created by jon on 2018-06-28.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit

var lib = CropLibrary(jsonName: "cropdata")

class CropLibraryController: UIViewController {

    @IBOutlet weak var CategoryBTN: UIButton!
    @IBOutlet weak var SearchBTN: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Page 2 Loaded")
        CategoryBTN.layer.cornerRadius = 7;
        SearchBTN.layer.cornerRadius = 7;

        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



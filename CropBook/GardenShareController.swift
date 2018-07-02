//
//  GardenShareController.swift
//  CropBook
//
//  Created by jon on 2018-07-01.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit

class GardenShareController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Page 3 Loaded")
        
        //Test the weather class
        let weather = Weather()
        weather.UpdateWaterRequirements(coEfficient: 0.4)
        print(weather.GetWaterRequirements())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

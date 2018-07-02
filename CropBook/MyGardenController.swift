//
//  FirstViewController.swift
//  CropBook
//
//  Created by jon on 2018-06-28.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit

var GardenList=[MyGarden?]()
class MyGardenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Page 1 Loaded")
        let notification = Notifications()


        notification.RequestPermission()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }


}


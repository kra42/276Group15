//
//  SecondViewController.swift
//  CropBook
//
//  Created by jon on 2018-06-28.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
//import "Notifications.swift"

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Page 2 Loaded")
        
        // Used this to test notification
        let notification = Notifications()
        notification.Schedule()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



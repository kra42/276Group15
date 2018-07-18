//
//  File.swift
//  CropBook
//
//  Created by Jason Wu on 2018-06-30.
//  Copyright © 2018 Jason Wu. All rights reserved.
//

import Foundation


import UIKit
import Firebase

class GardenSetupController: UIViewController {
    
    let ref=Database.database().reference()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var NameTF: UITextField!
    
    @IBOutlet weak var AddressTF: UITextField!
    
    @IBAction func CreateGarden(_ sender: Any) {
        if let garden=NameTF.text,let address=AddressTF.text{

            
            let newGarden=MyGarden(Name:garden, Address:address)
            OfflineGardenList.append(newGarden)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

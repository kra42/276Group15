//
//  File.swift
//  CropBook
//
//  Created by Jason Wu on 2018-06-30.
//  Copyright © 2018 Jason Wu. All rights reserved.
//

import Foundation


import UIKit

class GardenSetupController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var NameTF: UITextField!
    
    
    @IBOutlet weak var AddressTF: UITextField!
    

    
    @IBAction func CreateGarden(_ sender: Any) {
        if let garden=NameTF.text,let address=AddressTF.text{
            let newGarden=MyGarden(Name:garden, Address:address)
            GardenList.append(newGarden)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

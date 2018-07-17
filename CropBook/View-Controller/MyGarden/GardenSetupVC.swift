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
            
            //Write Garden into Firebase
            
            //Assign Attribute into garden
           let gardenID = self.ref.child("Gardens").childByAutoId().key
            self.ref.child("Gardens/\(gardenID)/gardenName").setValue(garden)
         //   self.ref.child("Gardens/\(gardenID)/Crops").setValue()
            self.ref.child("Gardens/\(gardenID)/Address").setValue(address)
            
            //Save gardenID into the user profile
            guard let userid=Auth.auth().currentUser?.uid else {return}
            let gardenRef=self.ref.child("Users/\(userid)/Gardens").child(gardenID)
            gardenRef.setValue(gardenID)
            gardenRef.setValue(["owner?":true])
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

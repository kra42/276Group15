//
//  ComposeVC.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-13.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ComposeVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var ref : DatabaseReference?
    var gardensIds : [PostData]?
    var gardenStrings : [String]?
    override func viewDidLoad() {
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        guard let gardenRef = ref?.child("users").child(uid!) else{ return }
        
        gardenRef.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let key = snap.key
                let value = snap.value
                print("key = \(key) , value = \(value!)")
            }
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost(_ sender: Any) {
        ref?.child("Posts").childByAutoId().child("test").setValue(textView.text)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removePost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

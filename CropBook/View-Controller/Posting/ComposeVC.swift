//
//  ComposeVC.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-13.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeVC: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    var ref : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost(_ sender: Any) {
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removePost(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
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

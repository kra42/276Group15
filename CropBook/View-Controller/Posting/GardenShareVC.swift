//
//  GardenShareController.swift
//  CropBook
//
//  Created by jon on 2018-07-01.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
let weather = Weather()
import FirebaseDatabase

class GardenShareController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref : DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    var postData = [String]()
    override func viewDidLoad() {
        ref = Database.database().reference()
        ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
                let post = snapshot.value as? String
                if let actualPost = post{
                    self.postData.append(actualPost)
                }
            
            self.tableView.reloadData()
        })
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        print("Page 3 Loaded")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //returns number of rows in data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    //return cell for display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
}

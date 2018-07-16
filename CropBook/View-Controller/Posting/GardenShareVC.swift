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
    var userRef : DatabaseReference?
    var gardensRef : DatabaseReference?
    var gardenRef : DatabaseReference?
    var cropsRef : DatabaseReference?
    @IBOutlet weak var tableView: UITableView!
    var gardenIds = [GardenData]()
    var postData = [Posting]()
    var myIndex = 0
    override func viewDidLoad() {
        ref = Database.database().reference()
        userRef = ref?.child("Users").child("Bob")
        userRef?.observe(.childAdded, with: { (gardenSnapshot) in
            let gardenId = gardenSnapshot.key as? String
            let userRole = gardenSnapshot.value as? String
            let gardenData = GardenData(gardenId: gardenId!, userRole: userRole!) as? GardenData
            self.gardenIds.append(gardenData!)
            self.tableView.reloadData()
        })
        
        gardensRef = ref?.child("Gardens")
        gardenRef = gardensRef?.child("Garden1")
        cropsRef = gardenRef?.child("Crops")
        /*
        ref?.observe(.value, with: { (snapshot) in
            let dataDict = snapshot.value as! [String : AnyObject]
            print(dataDict)
        })
        */
        
        /*
        cropsRef?.observe(.childAdded, with: { (gardenSnapshot) in
                let post = gardenSnapshot.value as? String
                let test = gardenSnapshot.key as? String
                if let actualPost = test{
                    let newPost = Posting(postTitle: actualPost)
                    self.postData.append(newPost)
                    print(test)
                }
            self.tableView.reloadData()
        })
        */
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
        return gardenIds.count
    }
    
    //return cell for display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = gardenIds[indexPath.row].getGardenId()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "postSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postSegue"{
            let receiverVC = segue.destination as! PostVC
            receiverVC.post = gardenIds[myIndex]
        }else{
            let receiverVC = segue.destination as! ComposeVC
            receiverVC.gardensIds = self.gardenIds
        }
    }
}

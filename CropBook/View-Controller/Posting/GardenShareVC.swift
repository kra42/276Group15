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
import FirebaseAuth

class GardenShareController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref : DatabaseReference?
    var postings = [PostData]()
    let uid = Auth.auth().currentUser?.uid
    var myIndex = 0
    var postInfo : Posting = Posting()
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        let userRef = ref?.child("Posts")
        userRef?.observe(.childAdded, with: { (gardenSnapshot) in
            let postId = gardenSnapshot.key as? String
            let postTitle = gardenSnapshot.childSnapshot(forPath: "Title").value as! String
            let postData = PostData(postId: postId!, postTitle: postTitle) as? PostData
            self.postings.append(postData!)
            self.tableView.reloadData()
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //returns number of rows in data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postings.count
    }
    
    //return cell for display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        
        cell?.textLabel?.text = postings[indexPath.row].getUserRole()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        createPosting()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{ self.performSegue(withIdentifier: "postSegue", sender: self)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postSegue"{
            let receiverVC = segue.destination as! PostVC
            receiverVC.post = postInfo
        }else{
            let receiverVC = segue.destination as! ComposeVC
            receiverVC.gardensIds = self.postings
        }
    }
    
    func createPosting(){
        let postRef = ref?.child("Posts/\(postings[myIndex].getGardenId())")
        self.postInfo.setPostRef(postRef: postRef!)
        postRef?.child("GardenId").observeSingleEvent(of: .value, with: { (snapshot) in
            let val = snapshot.value as! String
            self.postInfo.setGardenRef(gardenRef: val)
        })
        postRef?.child("Description").observeSingleEvent(of: .value, with: { (snapshot) in
            let val = snapshot.value as! String
            self.postInfo.setDescription(description: val)
        })
        postRef?.child("Title").observeSingleEvent(of: .value, with: { (snapshot) in
            let val = snapshot.value as! String
            self.postInfo.setTitle(title: val)
        })
        postRef?.child("Poster").observeSingleEvent(of: .value, with: { (snapshot) in
            let val = snapshot.value as! String
            self.postInfo.setGardenRef(gardenRef: val)
        })
        let crops = ["Blueberries","Apples","Asparagus"]
        self.postInfo.setCrops(cropNames: crops)
    }
    
    func getCropNames() -> [String]{
        let crops = [String]()
        return crops
    }
}

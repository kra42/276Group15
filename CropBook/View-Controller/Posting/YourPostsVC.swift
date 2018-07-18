//
//  YourPostsVC.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-18.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import Firebase

class YourPostsVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    let ref = Database.database().reference()
    var posts : [UserPost] = []
    var postId : String = ""
    var gardId : String = ""
    var acceptDatas : [AcceptData] = []
    override func viewDidLoad() {
        print(posts.count)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for : indexPath )
        cell.textLabel?.text = posts[indexPath.row].getId()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        postId = posts[indexPath.row].getId()
        getRequests()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute:{self.performSegue(withIdentifier: "acceptSegue", sender: self)})
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! acceptVC
        
    }
    
    func getRequests(){
        let gardenId = ref.child("Posts").child(postId).child("GardenId")
        let postRef = ref.child("Posts").child(postId).child("Requests")
        let gId = ""
        gardenId.observe(.value, with: {(snapshot) in
            let gId = snapshot.value as! String
        })
        postRef.observe(.value, with: {(snapshot) in
            for snap in snapshot.children{
                let userSnap = snap as! DataSnapshot
                let uID = userSnap.key
                let userDict = userSnap.value as! [String:AnyObject]
                let info = userDict["info"] as! String
                let name = userDict["name"] as! String
                let acptData = AcceptData()
                acptData.setInfo(info: info)
                acptData.setName(name: name)
                acptData.setPostId(pId: uID)
                acptData.setGardenId(gId: gId)
                print(acptData.gardenId)
            }
        })
    }
}

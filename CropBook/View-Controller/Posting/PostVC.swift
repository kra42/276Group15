//
//  PostVC.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-15.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PostVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    var ref = Database.database().reference()
    var post : Posting = Posting()
    var crops = [String]()
    let uid = Auth.auth().currentUser?.uid
    var vApply = true
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var harvestField: UILabel!
    @IBOutlet weak var cropsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionField.text = post.getDescription()
        descriptionField.isEditable = false
        postTitle.text = post.getTitle()
        harvestField.text = post.getHarvest()
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cropCell", for : indexPath )
        cell.textLabel?.text = crops[indexPath.row]
        return cell
    }
    
    func isValidApply(){
        let uRef = ref.child("Users/\(uid)")
        let gRef = uRef.child("Gardens")
        let pRef = uRef.child("Posts")
        gRef.observeSingleEvent(of: .value) { (snapshot) in
            print(self.post.getGardRef())
            if snapshot.hasChild(self.post.getGardRef()){
                self.vApply = false
                print("It happened")
            }
        }
        
        pRef.observeSingleEvent(of: .value) { (snapshot) in
            print(self.post.getRef().key)
            if snapshot.hasChild(self.post.getRef().key){
                self.vApply = false
                print("It happened")
            }
        }
    }
    
    @IBAction func applyPressed(_ sender: Any) {
        isValidApply()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute:{self.performSegue(withIdentifier: "applySegue", sender: self)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! ApplyVC
        receiverVC.validApply = self.vApply
        receiverVC.postRef = post.getRef()
    }
    
    
}

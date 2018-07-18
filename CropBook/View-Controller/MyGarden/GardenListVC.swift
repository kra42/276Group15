//
//  GardenInterface.swift
//  CropBook
//
//  Created by Jason Wu on 2018-07-01.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import Firebase

var GardenList=[MyGarden?]()
var OnlineGardenList=[MyGarden?]()
var OfflineGardenList=[MyGarden?]()

class GardenInterface: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let ref=Database.database().reference()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Online{
            return OnlineGardenList.count
        }
        return OfflineGardenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Online{
            GardenList = OnlineGardenList
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineGardenCell", for:indexPath) as! OnlineGardenTVC
            cell.gardenImage.image = UIImage(named: "gardenImageBlank.png")
            cell.gardenLabel.text = GardenList[indexPath.row]?.gardenName ?? "MyGarden"
            cell.deleteButton.addTarget(self, action: #selector(GardenInterface.deleteGarden), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            return (cell)
        } else {
            GardenList = OfflineGardenList
            let cell = tableView.dequeueReusableCell(withIdentifier: "gardenCell", for:indexPath) as! GardenTableViewCell
            cell.gardenImage.image = UIImage(named: "gardenImageBlank.png")
            cell.gardenLabel.text = GardenList[indexPath.row]?.gardenName ?? "MyGarden"
            cell.deleteButton.addTarget(self, action: #selector(GardenInterface.deleteGarden), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            cell.postButton.addTarget(self, action: #selector(GardenInterface.postGarden), for: .touchUpInside)
            cell.postButton.tag = indexPath.row
            return (cell)
        }
     }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gardenIndex = indexPath.row
        performSegue(withIdentifier: "GardenProfile", sender: self)
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var emptyGardenLabel: UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var segControl : UISegmentedControl!
    var gardenIndex:Int?
    var Online:Bool = false;

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.rowHeight = 120.0
        // Do any additional setup after loading the view.
        

    }
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        if GardenList.count>0{
            emptyGardenLabel.isHidden=true
        }else {
            emptyGardenLabel.isHidden=false
        }
   
    }
    
    @objc func postGarden(sender: UIButton){
        print("Posting")
        //Write Garden into Firebase
        
        //Assign Attribute into garden
        let passedIndex = sender.tag
        let garden = GardenList[passedIndex]?.gardenName
        let address = GardenList[passedIndex]?.address
        let gardenID = self.ref.child("Gardens").childByAutoId().key
        self.ref.child("Gardens/\(gardenID)/gardenName").setValue(garden)
        //self.ref.child("Gardens/\(gardenID)/Crops").setValue()
        self.ref.child("Gardens/\(gardenID)/Address").setValue(address)
        
        //Save gardenID into the user profile
        guard let userid=Auth.auth().currentUser?.uid else {return}
        let gardenRef=self.ref.child("Users/\(userid)/Gardens").child(gardenID)
        gardenRef.setValue(gardenID)
        gardenRef.setValue(["owner?":true])
    }
    
    //Delete a selected garden
    @objc func deleteGarden(sender: UIButton){
        let passedIndex = sender.tag
        
        // Create Alert Message
        let alert = UIAlertController(title: "Delete Garden?", message: GardenList[passedIndex]?.gardenName, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            print("DELETE")
            if self.Online{
                OnlineGardenList.remove(at: passedIndex)
            } else {
                OfflineGardenList.remove(at: passedIndex)
            }
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            print("no delete")
        }))
        self.present(alert, animated:true, completion:nil)
    }
    
    func GetOnlineGardens(){
        //Create a set of gardenID belongs to user
        var gardenSet=[String]()
        guard let userid=Auth.auth().currentUser?.uid else{return}
        print(userid)
        let myGardenRef=self.ref.child("Users/\(userid)/Gardens")
        myGardenRef.observe(.value, with: {(snap) in
            for id in snap.children.allObjects as! [DataSnapshot]{
                print(id.key)
                gardenSet.append(id.key)
            }
        })
        
        //retrieve garden that the user is participating from Firebase
        let gardenref=self.ref.child("Gardens")
        gardenref.observe(.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                for garden in snapshot.children.allObjects as! [DataSnapshot]{
                    // if gardenSet.contains(garden.key)
                    if gardenSet.contains(garden.key)
                    {
                        let gardenObject=garden.value as? [String: AnyObject]
                        let gardenname=gardenObject?["gardenName"]
                        print(gardenname!)
                        let address=gardenObject?["Address"]
                        let newGarden=MyGarden(Name: gardenname as! String, Address: address as! String)
                        OnlineGardenList.append(newGarden)
                    }
                }
                self.tableView.reloadData()
            }})
    }
    
    // Alternate tableview contents of displaying online profiles and offline profiles
    @IBAction func ChangeOfflineOnline(_ sender : Any){
        if segControl.selectedSegmentIndex == 0 {
            print("Offline")
            self.Online = false
            self.tableView.reloadData()
        }
        
        if segControl.selectedSegmentIndex == 1 {
            print("Online")
            self.Online = true
            OnlineGardenList.removeAll()
            GetOnlineGardens()
        }
    }

    //Pass gardenIndex to the next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GardenProfile")  {
            let nextController=segue.destination as!GardenCropList
            nextController.gardenIndex = gardenIndex!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

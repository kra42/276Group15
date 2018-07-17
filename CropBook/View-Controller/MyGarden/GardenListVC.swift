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
class GardenInterface: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let ref=Database.database().reference()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GardenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gardenCell", for:indexPath) as! GardenTableViewCell
        cell.gardenImage.image = UIImage(named: "gardenImageBlank.png")
        cell.gardenLabel.text = GardenList[indexPath.row]?.gardenName ?? "MyGarden"
        cell.deleteButton.addTarget(self, action: #selector(GardenInterface.deleteGarden), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return (cell)
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
    var gardenIndex:Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.rowHeight = 120.0
        // Do any additional setup after loading the view.
        
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
                    GardenList.append(newGarden)
                    }
                }
            }
            
        
        
        })
    
    }
            
    
        //closes first snapshot
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        if GardenList.count>0{
            emptyGardenLabel.isHidden=true
        }else {
            emptyGardenLabel.isHidden=false
        }
    }
    
    //Delete a selected garden
    @objc func deleteGarden(sender: UIButton){
        let passedIndex = sender.tag
        print("DELETE")
        GardenList.remove(at: passedIndex)
        self.tableView.reloadData()
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

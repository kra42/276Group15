//
//  GardenInterface.swift
//  CropBook
//
//  Created by Jason Wu on 2018-07-02.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import Firebase


class GardenCropList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var myIndex=0
    var gardenIndex = 0
    var myGarden: MyGarden!
    var Online:Bool?
    let ref=Database.database().reference()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(myGarden!.cropProfile.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cropCell", for:indexPath) as! CropTableViewCell
        let name: String? = myGarden?.cropProfile[indexPath.row].cropName
        cell.cropLabel?.text = name
        cell.cropImage?.image = UIImage(named: (myGarden?.cropProfile[indexPath.row].getImage())!)
        cell.deleteButton.addTarget(self, action: #selector(GardenCropList.deleteCrop), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "CropProfileSegue", sender: self)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 120.0
        self.tableView.backgroundColor = UIColor(red: 248.0/255.0, green: 1, blue: 210/255, alpha:1)

        // Do any additional setup after loading the view.
        self.myGarden = GardenList[gardenIndex]
        if self.Online! {
            //remove all crop before loading from firebase
            self.myGarden.cropProfile.removeAll()
            //retrieve Crops from the Firebase
            let gardenID = self.myGarden.gardenID
            let GardenRef = ref.child("Gardens/\(gardenID!)/CropList")
            GardenRef.observe(.value, with: {(snapshot) in
                for child in snapshot.children.allObjects as![DataSnapshot]{
                    let cropObject=child.value as? [String:AnyObject]
                    let cropname=cropObject?["CropName"]
                    let profname=cropObject?["ProfName"]
                    let cropinfo=lib.searchByName(cropName: cropname as! String)
                    let newCrop=CropProfile(cropInfo: cropinfo!, profName: cropname as! String)
                    newCrop.cropID=child.key
                    print(child.key)
                    self.myGarden.AddCrop(New: newCrop)
                }
                self.tableView.reloadData()
            })
        }
    }
    
    func dataRetrieval() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myGarden = GardenList[gardenIndex]
        self.tableView.reloadData()

        
        self.title = myGarden?.gardenName;
        print("Number of Crops = ", myGarden!.getSize())
    }
    
    //Delete a selected garden
    @objc func deleteCrop(sender: UIButton){
        let passedIndex = sender.tag
        
        let alert = UIAlertController(title: "Remove Crop from Garden?", message: myGarden.cropProfile[passedIndex].GetCropName(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            print("DELETE")
            
            if self.myGarden.getOnlineState(){
                let cropid=self.myGarden.cropProfile[passedIndex].cropID
                self.RemoveCropFromFB(cropid!)
            }
            
            self.myGarden.cropProfile.remove(at: passedIndex)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated:true, completion:nil)
            print("no delete")
        }))
        self.present(alert, animated:true, completion:nil)
    }
    
    func RemoveCropFromFB(_ id:String){
        let gardenID=myGarden.gardenID
        let CropRef=ref.child("Gardens/\(gardenID)/CropList/\(id)")
        CropRef.removeValue()
        print("Removed!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CropProfileSegue"{
            let receiverVC = segue.destination as! CropProfileViewController
            receiverVC.gardenIndex = self.gardenIndex
            receiverVC.myIndex = self.myIndex
            
        }else if segue.identifier == "createCrop"{
            let receiverVC = segue.destination as! CropCreateVC
            receiverVC.gardenIndex = gardenIndex
            receiverVC.Online = self.Online
        }
    }
}

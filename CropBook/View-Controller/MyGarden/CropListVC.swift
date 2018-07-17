//
//  GardenInterface.swift
//  CropBook
//
//  Created by Jason Wu on 2018-07-02.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit



class GardenCropList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var myIndex=0
    var gardenIndex = 0
    var refresher: UIRefreshControl!
    var myGarden: MyGarden!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(myGarden!.cropProfile.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cropCell", for:indexPath) as! CropTableViewCell
        let name: String? = myGarden?.cropProfile[indexPath.row].cropName
        cell.cropLabel?.text = name
        cell.cropImage?.image = UIImage(named: (myGarden?.cropProfile[indexPath.row].getImage())!)
        cell.deleteButton.addTarget(self, action: #selector(GardenInterface.deleteGarden), for: .touchUpInside)
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
        //self.navigationItem.setHidesBackButton(true, animated:true);
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myGarden = GardenList[gardenIndex]
        self.title = myGarden?.gardenName;
        print("Number of Crops = ", myGarden!.getSize())
        self.tableView.reloadData()
        //self.refresher.endRefreshing()
    }
    
    //Delete a selected garden
    @objc func deleteGarden(sender: UIButton){
        let passedIndex = sender.tag
        print("DELETE")
        myGarden.cropProfile.remove(at: passedIndex)
        self.tableView.reloadData()
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
        }
    }
    
    
}

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

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(GardenList[gardenIndex]!.cropProfile.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = GardenList[gardenIndex]?.cropProfile[indexPath.row].cropName
        
         return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "CropProfileSegue", sender: self)
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.setHidesBackButton(true, animated:true);
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = GardenList[gardenIndex]?.gardenName;
        print("Number of Crops = {}", GardenList[gardenIndex]!.getSize())
        self.tableView.reloadData()
        //self.refresher.endRefreshing()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CropProfileSegue"{
            let receiverVC = segue.destination as! CropProfileViewController
            receiverVC.myIndex = self.myIndex
        }else if segue.identifier == "createCrop"{
            let receiverVC = segue.destination as! CropCreateVC
            receiverVC.gardenIndex = gardenIndex

        }
    }

    @IBAction func backToGardens(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "unwindSegue1", sender: self)
    }
}

//
//  GardenInterface.swift
//  CropBook
//
//  Created by Jason Wu on 2018-07-02.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit

var myIndex=0

class GardenCropList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var gardenIndex:Int?
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gardenIndex==nil{
            return 0
        }
        
        return(GardenList[gardenIndex!]?.cropProfile.count)!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text=GardenList[gardenIndex!]?.cropProfile[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex=indexPath.row
        performSegue(withIdentifier: "", sender: self)
        
    }
    
    
    //Pass gardenIndex to the next viewcontroller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var nextController=segue.destination as!CreateCropViewController
        nextController.gardenIndex=gardenIndex
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

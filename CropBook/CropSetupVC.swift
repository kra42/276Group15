//
//  CropSetupViewController.swift
//  CropBook
//
//  Created by Jason Wu on 2018-07-02.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit

class CropSetupViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var gardenIndex:Int?
    
    @IBOutlet weak var CropTypeTF: UITextField!
    @IBOutlet weak var CropNameTF: UITextField!
    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    /*
    @IBAction func CreateButton(_ sender: Any) {
        /*
        if let cropType=CropTypeTF.text,
            let cropName=CropNameTF.text{
         // hardcoding crop id and watering variable, function in iteration 2 and 3.
            let newCrop=CropProfile(cropid: 0, cropName: cropName, cropType: cropType, wateringVariable: 0.0)
            GardenList[gardenIndex!]?.cropProfile.append(newCrop)
            
        }
         */
    }
    */
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblDropDown.delegate = self
        tblDropDown.dataSource = self
        tblDropDownHC.constant = 0
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectCrops(_ sender: AnyObject){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "numberofrooms")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "numberofrooms")
        }
        cell?.textLabel?.text = "\(indexPath.row + 1) rooms"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController=segue.destination as!GardenCropList
        
        nextController.gardenIndex=gardenIndex
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

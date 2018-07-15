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
    
    @IBOutlet weak var emptyGardenLabel: UILabel!
    @IBOutlet weak var tableView : UITableView!
    var gardenIndex:Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DatabaseReference!
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

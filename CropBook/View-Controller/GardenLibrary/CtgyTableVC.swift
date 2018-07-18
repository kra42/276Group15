//
//  CtgyTableViewController.swift
//  CropBook
//
//  Created by Bowen He on 2018-07-02.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit

var myIndex = 0
var ctgyLib = [CropInfo]()

class CtgyTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myIndex = 0
        //print(selectedCategory)
        // #warning Incomplete implementation, return the number of rows
        return ctgyLib.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        var selectedLib = ctgyLib
        cell.cropLabel?.text = selectedLib[indexPath.row].getName()
        cell.cropImage?.image = UIImage(named: selectedLib[indexPath.row].getImage())
        tableView.rowHeight = 120.0
        tableView.backgroundColor = UIColor(red: 248.0/255.0, green: 1, blue: 210/255, alpha:1)
        // Configure the cell...
        return cell
    }
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "ctgySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! CInfoViewController
        receiverVC.cropFound = ctgyLib[myIndex]
    }
}

//
//  TableViewController.swift
//  cvdemo
//
//  Created by Akito Ito on 2018/03/25.
//  Copyright © 2018 Akito Ito. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var json: [Any] = []
    var dataSet: [CellModel] = [CellModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.json.forEach { j in
            let r = j as! NSDictionary
            let id = r["item_id"] as! String
            let desc = r["common04"] as! String
            let imageUrl = r["common03"] as! String
            dataSet.append(CellModel(id: id, desc: desc, imageUrl: URL(string: imageUrl)))
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.json.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! TableCellTableViewCell
        
        // Configure the cell...
        cell.setCell(model: self.dataSet[indexPath.row])

        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        //self.dismissViewControllerAnimated(true, completion: nil)  //上記サイトではこのコードだったが、
        self.dismiss(animated: true, completion: nil) //現在ではこのように書くらしい。
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

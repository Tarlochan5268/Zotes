//
//  CategoryTableViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-15.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.title = "Categories"
        
        let barbutton = UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory(button:)))
        
        self.navigationController?.navigationItem.rightBarButtonItem = barbutton
        
        self.navigationItem.title = "Add Category"
        self.navigationItem.rightBarButtonItem = barbutton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func addCategory(button:UIBarButtonItem)
    {
        let ac = UIAlertController(title: "Enter a new Category", message: nil, preferredStyle: .alert)
               ac.addTextField()

               let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
                   let answer = ac.textFields![0]
                
                
                self.data.append(answer.text!)
                   // do something interesting with "answer" here
                print(self.data)
               }

               ac.addAction(submitAction)

               present(ac, animated: true)
           
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
   

    //data to show is
    var data = ["Uncategorized"]
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForCategory", for: indexPath)

        // Configure the cell...

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

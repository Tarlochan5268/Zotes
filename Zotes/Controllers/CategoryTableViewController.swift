//
//  CategoryTableViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-15.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categories")
        
        do
        {
            let x = try context.fetch(fetchRequest)
            for category in x
            {
            
                if category.value(forKey: "categoryName") != nil
                {
                    data.append((category.value(forKey: "categoryName")) as! String)
                    
                }
            }
            
        }
        catch
        {
            print("Error when fetching the categories")
        }

        
        self.navigationController?.title = "Categories"
        
        let barbutton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addCategory(button:)))
        
        self.navigationController?.navigationItem.rightBarButtonItem = barbutton
        
        self.navigationItem.title = "Categories"
        self.navigationItem.rightBarButtonItem = barbutton
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Delete Row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Asked For Delete")
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                          let context = appdelegate.persistentContainer.viewContext
                          
                          let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
                          let category = NSManagedObject(entity: entity!, insertInto: context)
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categories")
            
            do
            {
                let x = try context.fetch(fetchRequest)
                context.delete(x.first!)
              data.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            catch
            {
                
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    @objc func addCategory(button:UIBarButtonItem)
    {
        let ac = UIAlertController(title: "Enter a new Category", message: nil, preferredStyle: .alert)
               ac.addTextField()

               let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
                   let answer = ac.textFields![0]
                
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appdelegate.persistentContainer.viewContext
                
                let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
                let category = NSManagedObject(entity: entity!, insertInto: context)
                category.setValue(answer.text!, forKey: "categoryName")
                
                do
                {
                    try context.save()
                                  self.data.append(answer.text!)
                }
                catch
                {
                    print("Error While Adding Category")
                }
                
              
                   // do something interesting with "answer" here
                print(self.data)
                self.tableView.reloadData()
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

        cell.textLabel?.text = data[indexPath.row]
        
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

//
//  SaveNoteViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-17.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import BottomPopup
import CoreData
class SaveNoteViewController: BottomPopupViewController, UITableViewDelegate, UITableViewDataSource {
    
    var senderr:CreateNoteViewController?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCellForSave")
        
        //print()
        cell?.textLabel?.text = data[indexPath.row]
        print("")
        return cell!
    }
    

    var titleofnot:String?
    var images:[UIImage] = []
    var content:String?
    var date:Date?
    var location:String?
    var categories:[Categories] = []
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        //print("Get Category for \(getCategory(of: ))")
        
        self.save()
        self.senderr?.saved = true
        self.dismiss(animated: true, completion: nil)
   
    }
    var data:[String] = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
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

        
    }
    
    override func getPopupHeight() -> CGFloat {
        return 429.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func save() -> Bool
     {
         let appdelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appdelegate.persistentContainer.viewContext
       
         let entity = NSEntityDescription.entity(forEntityName: "Zote", in: context)
         let zote = NSManagedObject(entity: entity!, insertInto: context)
         
         zote.setValue(self.titleofnot, forKey: "title")
         zote.setValue(self.location, forKey: "location")
         zote.setValue(self.content, forKey: "content")
         zote.setValue(self.date, forKey: "date")
            if let index = tableView.indexPathForSelectedRow?.row
            {

                zote.setValue(getCategory(of: data[index]), forKey: "category")
            }
        else
        {
            zote.setValue(getCategory(of: "Uncategorized"), forKey: "category")
        }
        
         
         do
         {
             try context.save()
             return true
             
         }
         catch
         {
             return false
         }
         
     }
     
    
    
    func getCategory(of:String) -> Categories?
    {
        var returner:Categories? = nil
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                      let context = appdelegate.persistentContainer.viewContext
                      
                   //   let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
                   //   let category = NSManagedObject(entity: entity!, insertInto: context)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categories")
        
        do
        {
            let x = try context.fetch(fetchRequest) as! [Categories]
            print(x)
            for category in x
            {
                if let cname = category.categoryName
                {
                    if cname == of {
                        returner = category
                    }
                }
            }
            //context.delete(x.first!)
         // data.remove(at: indexPath.row)
        // self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        catch
        {
            
        }
        return returner
    }
     
    

}

//
//  FirstViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-10-30.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIContextMenuInteractionDelegate{
    
    @available(iOS 13.0, *)
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        <#code#>
    }
    
    
  
    var zotes:[Zote] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return zotes.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! ZotesCardTableViewCell
        if #available(iOS 13.0, *) {
            let interaction = UIContextMenuInteraction(delegate: self)
            
        } else {
            // Fallback on earlier versions
        }
               
        cell.title.text = zotes[indexPath.row].title!
        
        cell.sampleText.text = zotes[indexPath.row].content!
        cell.dateAndLocation.text = "\(zotes[indexPath.row].date!.formatDate()) - \(zotes[indexPath.row].location!)"
        
        return cell
    }
    

    @IBAction func filterTapped(_ sender: Any) {
        
        // MARK: - To BE Done By Tarlochan
        
        
        
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.tableView.rowHeight = 100
        //self.tableView.estimatedRowHeight = 600
        // Do any additional setup after loading the view.
        //accessCoreData();
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Asked For Delete")
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                          let context = appdelegate.persistentContainer.viewContext
                          
                          //let entity = NSEntityDescription.entity(forEntityName: "Zote", in: context)
                          //let category = NSManagedObject(entity: entity!, insertInto: context)
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Zote")
            
            do
            {
                let x = try context.fetch(fetchRequest)
                let result = x as! [Zote]
                
                print("deleting \(result[indexPath.row])")
                context.delete(result[indexPath.row])
                //print(zotes)
                print(indexPath.row )
                zotes.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                
            }
            catch
            {
                
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Zote")
               do
               {
                let x = try context.fetch(fetchRequest) as! [Zote]
                zotes = x
                print(x.count)
                tableView.reloadData()
                
               }
               catch
               {
                   //Fuck Swift & iOS
               }
        
        
        
        
        
        
        
    }
    /*func accessCoreData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // create Data
        let zote = Zote(context: context);
        zote.content = "This is content inside the zote. Kishore is boy with  a big toy XD"
        zote.date = Date()
        zote.location = "Kishore House"
        zote.title = "Kishore ustaad ji da ghar de vich apa agye"
        
        let category = Categories(context: context);
        category.categoryName = "Common"
        
     
        zote.category = category
        zote.category?.categoryName = category.categoryName
        appDelegate.saveContext()
        
        
        // View data
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Zote")
            
            do{
              let res = try context.fetch(request)//array of zote object [Zote]
              
              let fetchedZote = res.first as? Zote
                print(fetchedZote?.title ?? "")
              print(fetchedZote?.date ?? "")
                print(fetchedZote?.location ?? "")
                print(fetchedZote?.content ?? "")
                print(fetchedZote?.category?.categoryName ?? "")
                print(res)
              
            }catch let error{
              print(error)
            }
        
        
        
    }*/


}


extension Date
{
    func formatDate() -> String
    {
     
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        return dateFormatterPrint.string(from: self)
    }
}

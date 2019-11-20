//
//  FirstViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-10-30.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
 
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                    let context = appdelegate.persistentContainer.viewContext
                                    
                                 //   let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
                                 //   let category = NSManagedObject(entity: entity!, insertInto: context)
            
            
                      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Zote")
            let predicate1 = NSPredicate(format: "title contains %@", searchText)
            let predicate2 = NSPredicate(format: "content contains %@", searchText)
            let compound = NSCompoundPredicate(type: .or, subpredicates: [predicate1, predicate2])
           // fetchRequest.predicate = compound
            
                      do
                      {
                          let x = try context.fetch(fetchRequest) as! [Zote]
                        zotes = x
                        tableView.reloadData()
                 
                          //context.delete(x.first!)
                       // data.remove(at: indexPath.row)
                      // self.tableView.deleteRows(at: [indexPath], with: .fade)
                      }
                      catch
                      {
                          print("Some error")
                      }
            
        }
        else
        {
            
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                let context = appdelegate.persistentContainer.viewContext
                                
                             //   let entity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
                             //   let category = NSManagedObject(entity: entity!, insertInto: context)
        
        
                  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Zote")
        let predicate1 = NSPredicate(format: "title contains %@", searchText)
        let predicate2 = NSPredicate(format: "content contains %@", searchText)
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicate1, predicate2])
        fetchRequest.predicate = compound
        
                  do
                  {
                      let x = try context.fetch(fetchRequest) as! [Zote]
                    zotes = x
                    tableView.reloadData()
             
                      //context.delete(x.first!)
                   // data.remove(at: indexPath.row)
                  // self.tableView.deleteRows(at: [indexPath], with: .fade)
                  }
                  catch
                  {
                      print("Some error")
                  }
        print(searchText)
        }
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: {suggestedActions in
                   print(suggestedActions)
            return self.makeContextMenu(for:indexPath.row) })
    }
    /*
    // MARK: - Sample 3D Touch
    @available(iOS 13.0, *)
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: {suggestedActions in
            print(suggestedActions)
            return self.makeContextMenu(for:) })
    }
    */
    // MARK: 3D TOUCH IMPLEMENTATION
    @available(iOS 13.0, *)
    func makeContextMenu(for cellat:Int) -> UIMenu
    {
       
        let nolabel = UIAction(title: "No Label", image: UIImage(named: "white")) { action in
            // Show system share sheet
            
            self.zotes[cellat].label = "white"
            self.tableView.reloadData()
            print("Cell \(cellat) to WHITE")
            
        }
        let systemPink = UIAction(title: "Pink", image: UIImage(named: "systemPink")) { action in
            // Show system share sheet
            
            self.zotes[cellat].label = "systemPink"
            self.tableView.reloadData()
                        print("Cell \(cellat) to PINK")
        }
        let systemTeal = UIAction(title: "Teal", image: UIImage(named: "systemTeal")) { action in
            // Show system share sheet
            
            self.zotes[cellat].label = "systemTeal"
            self.tableView.reloadData()
                        print("Cell \(cellat) to TEAL")
        }
        let systemGreen = UIAction(title: "Green", image: UIImage(named: "systemGreen")) { action in
            // Show system share sheet
            
            self.zotes[cellat].label = "systemGreen"
            self.tableView.reloadData()
                        print("Cell \(cellat) to GREEN")
        }
        let systemOrange = UIAction(title: "Orange", image: UIImage(named: "systemOrange")) { action in
            // Show system share sheet
            
            self.zotes[cellat].label = "systemOrange"
            self.tableView.reloadData()
                        print("Cell \(cellat) to ORANGE")
        }

        // Create and return a UIMenu with the share action
        return UIMenu(title: "Add Label", children: [nolabel, systemPink, systemTeal, systemGreen, systemOrange])
    }
    
  
    var zotes:[Zote] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return zotes.count
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: - CELL SENDING
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! ZotesCardTableViewCell
       
        if let color = zotes[indexPath.row].label
        {
            cell.backgroundColor = getColor(of: color)
            zotes[indexPath.row].label = color
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                   let context = appdelegate.persistentContainer.viewContext
            do
            {
                try context.save()
            }
            catch
            {
                //fuck swift and ios
            }

        }
        else
        {
            cell.backgroundColor = .white
        }
        print("Adding Cell Number: \(indexPath.row) with color: \(zotes[indexPath.row].label)")
        
        cell.title.text = zotes[indexPath.row].title!
        
        cell.sampleText.text = zotes[indexPath.row].content!
        cell.dateAndLocation.text = "\(zotes[indexPath.row].date!.formatDate()) - \(zotes[indexPath.row].location!)"
        
        return cell
    }
    

    @IBAction func filterTapped(_ sender: Any) {
        
        // MARK: - To BE Done By Tarlochan
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popupvc = storyboard.instantiateViewController(withIdentifier: "filterVC")
        present(popupvc, animated: true, completion: nil)
        
        
    }
    // MARK: - COLOR OPTIONS
    func getColor(of colorString:String) -> UIColor
    {
       if(colorString == "systemPink")
        {
            return .systemPink
        }
        
        else if(colorString == "systemGreen")
        {
            return .systemGreen
        }
        
        else if(colorString == "systemTeal")
        {
            return .systemTeal
        }
        
        else if(colorString == "systemOrange")
        {
            return .systemOrange
        }
        else
        {
            return .white
        }
    }
    
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
               tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)
       
        
        self.tableView.rowHeight = 100
        //self.tableView.estimatedRowHeight = 600
        // Do any additional setup after loading the view.
        //accessCoreData();
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NoteVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "NoteVC") {
            let vc = segue.destination as! NoteViewController
            vc.rowSelected = self.tableView.indexPathForSelectedRow?.row
            vc.zotes = zotes
            vc.colour = getColor(of: zotes[self.tableView.indexPathForSelectedRow!.row].label!)
        }
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
                do
                {
                   try context.save()
                }
                catch{
                    
                    //Something shit has already happened.
                }
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
        
        
        print("Appearing")
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


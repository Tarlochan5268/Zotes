//
//  FirstViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-10-30.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        accessCoreData();
    }
    
    func accessCoreData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // create Data
        let zote = Zote(context: context);
        zote.content = "This is content inside the zote. Kishore is boy with  a big toy XD"
        zote.date = Date()
        zote.location = "Kishore House"
        zote.title = "Kishore ustaad ji da ghar"
        
        let category = Categories(context: context);
        category.categoryName = "Common"
        
     
        zote.categories = category
        zote.categories?.categoryName = category.categoryName
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
                print(fetchedZote?.categories?.categoryName ?? "")
                print(res)
              
            }catch let error{
              print(error)
            }
        
        
        
    }


}


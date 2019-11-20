//
//  Zote.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-13.
//  Copyright © 2019 Zero. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ZoteNote
{
    private var context:NSManagedObjectContext!
    private var title:String!
    private var content:String!
    private var location:String!
    private var date = Date()
    
    init(withTitle title:String, content:String, location:String)
    {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appdelegate.persistentContainer.viewContext
        self.title = title
        self.content = content
        self.location = location
        
        
    }
    func save() -> Bool
    {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
      
        let entity = NSEntityDescription.entity(forEntityName: "Zote", in: self.context!)
        let zote = NSManagedObject(entity: entity!, insertInto: context)
        
        zote.setValue(self.title, forKey: "title")
        zote.setValue(self.location, forKey: "location")
        zote.setValue(self.content, forKey: "content")
        zote.setValue(self.date, forKey: "date")
        
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
    
    
   
}

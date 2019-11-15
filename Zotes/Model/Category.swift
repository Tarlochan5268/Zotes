//
//  Category.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-15.
//  Copyright © 2019 Zero. All rights reserved.
//

import Foundation
import  CoreData
import UIKit
class Category
{
    
    
    
    //adding changes
    var categoryName:String!
    var context:NSManagedObjectContext!
    init(withName:String)
    {
        self.categoryName = withName
        let delegate = UIApplication.shared.delegate as! AppDelegate
        self.context = delegate.persistentContainer.viewContext
        
    }
    func save() -> Bool
    {
        let entity = NSEntityDescription.entity(forEntityName: "Categories", in: self.context!)
               let category = NSManagedObject(entity: entity!, insertInto: context!)
        
        category.setValue(self.categoryName, forKey: "categoryName")
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

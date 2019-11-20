//
//  AppDelegate.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-10-30.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import Firebase
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?

    var ref:DatabaseReference!

    // MARK: - Default Tags
    let tags:[UIColor] = [ .systemPink, .systemTeal, .systemGreen, .systemOrange]
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
  
        if let uncategorized = getCategory(of: "Uncategorized")
        {
            
        }
        else
        {
            let entity = NSEntityDescription.entity(forEntityName: "Categories", in: self.persistentContainer.viewContext)
            let category = NSManagedObject(entity: entity!, insertInto: self.persistentContainer.viewContext)
                           category.setValue("Uncategorized", forKey: "categoryName")
                           
                           do
                           {
                            try persistentContainer.viewContext.save()
                                             
                           }
                           catch
                           {
                               print("Error While Adding Category")
                           }
                           
        }
        
        return true
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Zotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


//
//  SettingsViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-10-30.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:DatabaseReference!
    var settingsOptions = [
        "Sign In","About"
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingsOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "optionCell")
        cell?.textLabel?.text = settingsOptions[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            
            if(settingsOptions[0].starts(with: "Signed In As"))
            {
                let alert = UIAlertController(title: "Warning", message: "You're Signed In As: \(settingsOptions[0]). If not \(settingsOptions[0]) You can logout.  ", preferredStyle: .alert)
                              
                                 
                alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: logout))
                 alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
                                  self.present(alert, animated: true)
            }
            else
            {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                     let signInScreen = storyboard.instantiateViewController(withIdentifier:"signInScreen")
                     
                     navigationController?.pushViewController(signInScreen, animated: true)
            }
            
        }
        else if(indexPath.row == 1)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
             let aboutScreen = storyboard.instantiateViewController(withIdentifier:"aboutScreen")
             
             navigationController?.pushViewController(aboutScreen, animated: true)
        }
    }
    
    func logout(alert:UIAlertAction)
    {
        if let _:[String:String] = UserDefaults.standard.dictionary(forKey: "email") as? [String:String]
        {
           
            //let val:[String:String] = UserDefaults.standard.dictionary(forKey: "email") as! [String:String]
            UserDefaults.standard.setValue(nil, forKey: "email")
            settingsOptions[0] = "Sign In"
            tblView.reloadData()
        }
    }

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
       // print(UserDefaults.standard.object(forKey: "email") as [Stri
        if let val:[String:String] = UserDefaults.standard.dictionary(forKey: "email") as? [String:String]
        {
           
            //let val:[String:String] = UserDefaults.standard.dictionary(forKey: "email") as! [String:String]
            print(val)
            if !val.isEmpty
            {
                settingsOptions[0] = "Signed In As:  \(val["fullName"]!)"
                tblView.reloadData()
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

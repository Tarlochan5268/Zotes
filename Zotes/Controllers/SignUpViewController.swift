//
//  SignUpViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-02.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBAction func onSignUp(_ sender: Any) {
        
        
        if(fullName.text == "" || email.text == "" || password.text == "")
        {
          
            let alert = UIAlertController(title: "Error", message: "Please Enter Data in all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        else if(!(email.text! as String).isEmail())
        {
            let alert = UIAlertController(title: "Error", message: "Please Enter a valid Email.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        else
        {
            ref.observe(.value, with: {(snapshot) in if(snapshot.childSnapshot(forPath: "users").hasChild(self.email.text!.convertToFirebaseCompatible()))
                {
                    let alert = UIAlertController(title: "Warning", message: "User Already Exists. Please Try Login or Forgot Password.", preferredStyle: .alert)
                
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.popToLogin))
                
                    self.present(alert, animated: true)
                }
                
            })
        }
            
            let em = email.text?.convertToFirebaseCompatible()
            let pass = password.text
            let fullname = fullName.text
            
            ref.child("users").child("\(em!)").setValue(["fullName":fullname,"password":pass])
        }
        
        
        
    

    
    func popToLogin(alert:UIAlertAction!)
    {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var password: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

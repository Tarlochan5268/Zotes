//
//  SignInViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-02.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {

    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func email(_ sender: UITextField) {
    }
    
    @IBAction func onSignIn(_ sender: UIButton){
            
        ref.observe(.value, with: {(snapshot) in if(snapshot.childSnapshot(forPath: "users").hasChild(self.emailField.text!.convertToFirebaseCompatible()))
        {
            let details = snapshot.childSnapshot(forPath: "users").childSnapshot(forPath: self.emailField.text!.convertToFirebaseCompatible())
            let newDetail:[String:String] = details.value as! [String:String]
            if(newDetail["password"] == self.passwordField.text)
            {
                UserDefaults.standard.set(newDetail, forKey: "email")
                print("\(newDetail) Added")
                self.navigationController?.popViewController(animated: true)
                
            }
            else
            {
                let alert = UIAlertController(title: "Warning", message: "Invalid Password. Please Try Forgotting Password.  ", preferredStyle: .alert)
                
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                alert.addAction(UIAlertAction(title: "Forgot Password", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
        }
            else
        {
            let alert = UIAlertController(title: "Warning", message: "User Does Not Exist. Please Create a new Zotes account with email \(self.emailField.text!) ", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            
                self.present(alert, animated: true)
            }
        
    })
    }
    
    @IBAction func openSignUp(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let signUpScreen = storyboard.instantiateViewController(withIdentifier:"signUpScreen")
         
         navigationController?.pushViewController(signUpScreen, animated: true)
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

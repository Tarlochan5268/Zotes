//
//  SignInViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-02.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

//
//  AbouApplicationtViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-02.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class AboutApplicationtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openGithub(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/narangkishore98/Zotes") {
            UIApplication.shared.open(url)
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

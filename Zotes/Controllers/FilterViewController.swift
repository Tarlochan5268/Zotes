//
//  FilterViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-19.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    
    var senderr:FirstViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var date: UISegmentedControl!
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        senderr.update(index: date.selectedSegmentIndex)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

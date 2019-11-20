//
//  NoteViewController.swift
//  Zotes
//
//  Created by Das Tarlochan Preet Singh on 2019-11-20.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {



    @IBAction func goBackHome(_ sender: Any)
    {
        view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func goToAttachments(_ sender: Any)
    {
        performSegue(withIdentifier: "ImagesVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ImagesVC")
        {
            let vc = segue.destination as! ImagesViewController
            vc.rowSelected = self.rowSelected
            vc.zotes = self.zotes
            vc.colour = self.colour
        }
    }
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UITextView!
    
    var colour:UIColor?
    var zotes:[Zote] = []
    var rowSelected:Int?
    override func viewDidLoad() {
        category.text = "Category : "+(zotes[rowSelected!].category?.categoryName ?? "Empty")
        location.text = "Location : "+(zotes[rowSelected!].location ?? "Empty")
        content.text = zotes[rowSelected!].content
        date.text = "Date : "+(zotes[rowSelected!].date?.formatDate() ?? "Empty")
        self.title = zotes[rowSelected!].title
        navBar.topItem?.title = zotes[rowSelected!].title
        self.view.backgroundColor = colour
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

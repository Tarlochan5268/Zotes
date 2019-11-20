//
//  ImagesViewController.swift
//  Zotes
//
//  Created by Das Tarlochan Preet Singh on 2019-11-20.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    var index = 0
    
    var colour:UIColor?
    var zotes:[Zote] = []
    var rowSelected:Int?
    
    var imagesArray = ["systemPink","systemTeal","systemGreen","systemOrange"]
    let systemPink:UIImage = UIImage(named: "systemPink")!
    let systemTeal:UIImage = UIImage(named: "systemTeal")!
    let systemGreen:UIImage = UIImage(named: "systemGreen")!
    let systemOrange:UIImage = UIImage(named: "systemOrange")!
    var images:[UIImage]!
    @IBAction func goBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        self.view.backgroundColor = colour
        images = [systemPink,systemTeal,systemGreen,systemOrange]
        imageView.image =  images[index]
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextImage(_ sender: Any)
    {
        if(index == 3)
        {
            index = 0
        }
        else
        {
            index = index + 1
        }
        imageView.image =  images[index]
    }
    
    @IBAction func prevImage(_ sender: Any)
    {
        if(index == 0)
        {
            index = 3
        }
        else
        {
            index = index - 1
        }
        imageView.image =  images[index]
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

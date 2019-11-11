//
//  ShowAddedImagesViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-09.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit

class ShowAddedImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  var cell = UICollectionViewCell.reusable

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ShowAddedImageCollectionViewCell
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
        
        
    }
    

    var images:[UIImage]!
    
    
    
    
    override func viewDidLoad() {
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

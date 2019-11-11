//
//  SecondViewController.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-10-30.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class CreateNoteViewController: UIViewController , CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var images:[UIImage] = []
   
    @IBAction func optionsTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Image from Photos", style: .default, handler: openGallary))
        
       
        alert.addAction(UIAlertAction(title: "Add Image from Camera", style: .default, handler:openCamera ))
         
        
        alert.addAction(UIAlertAction(title: "View Attached Images", style: .default, handler: openSelectedImages(action:)))
       
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    let locationmanager = CLLocationManager()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround() 
                  
                  locationmanager.requestAlwaysAuthorization()
                  locationmanager.requestWhenInUseAuthorization()
                  if CLLocationManager.locationServicesEnabled()
                  {
                      locationmanager.delegate = self
                      locationmanager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                      locationmanager.startUpdatingLocation()
                  }
           
           
    
           
           if let currentLocation = locationmanager.location
           {
               let geo = CLGeocoder()
         
               geo.reverseGeocodeLocation(currentLocation, completionHandler: {(placemark, error) in
    
                   print(placemark![0].locality as Any)
                   print(placemark![0].name as Any)
          
               })
           }
        else
           {
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location:CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        print("Locations are \(location.latitude) , \(location.longitude)")
    }

    @IBOutlet weak var titleObj: UITextField!
 
    @IBAction func title(_ sender: Any) {
        self.navigationItem.title  = titleObj.text!
       


    }
    override func viewWillAppear(_ animated: Bool) {
        
        print(images)
    }
    @IBOutlet weak var note: UITextView!
    
    
    func openCamera(action:UIAlertAction) -> Void
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let vc = UIImagePickerController()
            vc.sourceType = .camera

            vc.delegate = self
            present(vc, animated: true)
        }
        else
        {
                let alert = UIAlertController(title: "Error", message: "Camera isn't working properly on this iOS device.", preferredStyle:.alert)
                      
 
                      alert.addAction(UIAlertAction(title:"OK", style:.cancel, handler: nil))
                      present(alert, animated: true)
        }
    }
    func openGallary(action:UIAlertAction) -> Void
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            let vc = UIImagePickerController()
            vc.sourceType = .savedPhotosAlbum
            vc.delegate = self
            vc.allowsEditing = false
            present(vc, animated:true)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Photos Gallery isn't working properly on this iOS device.", preferredStyle:.alert)
                                 
            
                                 alert.addAction(UIAlertAction(title:"OK", style:.cancel, handler: nil))
                                 present(alert, animated: true)
        }
    }
    
    func openSelectedImages(action:UIAlertAction)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bc = storyboard.instantiateViewController(withIdentifier: "showAddedImages") as! ShowAddedImagesViewController
        
        bc.images = images
        present(bc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //print to check if the funciton is being called or not
        print("Testing call imagePickerController didiFinishPickingWithMediaInfo")
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        //print(image)
        images.append(image)
        
        let imageName = "NotesPic" // your image name here
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(imageName).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        let newImage: UIImage = image
        try? newImage.pngData()?.write(to: imageUrl)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to discard the note. All the chages will not be saved", preferredStyle:.alert)
        
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: handle))
        alert.addAction(UIAlertAction(title:"Cancel", style:.cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func handle(alert:UIAlertAction)
    {
        titleObj.text = ""
        note.text = ""
        navigationItem.title = "New Note"
    }
   
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

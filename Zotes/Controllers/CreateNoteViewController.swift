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
    
   
    @IBAction func optionsTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Image from Photos", style: .default, handler: openGallary))
        
       
        alert.addAction(UIAlertAction(title: "Add Image from Camera", style: .default, handler:openCamera ))
         
        
        alert.addAction(UIAlertAction(title: "View Attached Images", style: .default, handler: nil))
       
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    let locationmanager = CLLocationManager()
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
               
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
            print("GEO OBJECT CREATED")
            geo.reverseGeocodeLocation(currentLocation, completionHandler: {(placemark, error) in
 
                print(placemark![0].locality as Any)
                print(placemark![0].name as Any)
       
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location:CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        print("Locations are \(location.latitude) , \(location.longitude)")
    }

    @IBOutlet weak var titleObj: UITextField!
    @IBOutlet weak var navigation: UINavigationBar!
    @IBAction func title(_ sender: Any) {
        
    }
    @IBOutlet weak var note: UITextView!
    
    
    func openCamera(action:UIAlertAction) -> Void
    {
        let vc = UIImagePickerController()
        vc.sourceType = .camera

        vc.delegate = self
        present(vc, animated: true)
    }
    func openGallary(action:UIAlertAction) -> Void
    {
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image)
    }
}


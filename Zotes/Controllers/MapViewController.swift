//
//  MapViewController.swift
//  Zotes
//
//  Created by Das Tarlochan Preet Singh on 2019-11-20.
//  Copyright © 2019 Zero. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,CLLocationManagerDelegate, MKMapViewDelegate{
    
    
    @IBAction func goBack(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    var zotes:[Zote] = []
    var rowSelected:Int?
    let locationManager:CLLocationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let location = CLLocation(latitude: 43.772563, longitude: -79.334054)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center:center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.mapView.setRegion(region, animated: true)
        
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

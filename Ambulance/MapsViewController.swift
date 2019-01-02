//
//  MapsViewController.swift
//  Ambulance
//
//  Created by Imac on 30/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import GoogleMaps


class MapsViewController: UIViewController, GMSMapViewDelegate , CLLocationManagerDelegate {

    
        var locationManager = CLLocationManager()
    let long_ = ListeLongchauffeur[idx]
    let lat_ = ListeLatchauffeur[idx]
    
    @IBOutlet weak var mapv: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: (lat_), longitude: (long_), zoom: 14)
        
        self.mapv.camera = camera
        
        let position = CLLocationCoordinate2D(latitude: lat_, longitude: long_)
        let marker = GMSMarker(position: position)
        marker.title = "nom_chaufeur"
        marker.map = mapv
        
    }
    

    @IBAction func but_back(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_esppartner") as! EspaceProPartnerViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("---------- update x location in maps -----------")
        
    
        let position = CLLocationCoordinate2D(latitude: lat_, longitude: long_)
        let marker = GMSMarker(position: position)
        marker.title = "nom_chaufeur"
        marker.map = mapv
            
        
        
        
    }

}

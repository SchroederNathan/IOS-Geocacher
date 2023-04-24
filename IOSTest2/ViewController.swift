//
//  ViewController.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-19.
//

import UIKit
import MapKit

import CoreLocation

class ViewController: UITableViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // Request location
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }

    }





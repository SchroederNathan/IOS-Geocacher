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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MapDetailsViewController else { return }
        
        destination.locationManager = locationManager
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = "Location Name"
        cell.detailTextLabel?.text = "Description"
        return cell
    }

    }





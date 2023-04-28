//
//  MapDetailsViewController.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-24.
//

import UIKit
import MapKit

class MapDetailsViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationNameTextField: UITextField!
    @IBOutlet var locationDescriptionTextView: UITextView!
    
    //MARK: - Actions

    
    //MARK: - Properties
    var locationManager: CLLocationManager!
    var savedLocations = [Location]()
    var locationStore: LocationStore!
    //var currentLocation:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .satellite
        mapView.isScrollEnabled = false
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        
        
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    

        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    
    @IBAction func addLocation(_ sender: Any) {
        let confirmationView = ConfirmationDialog()
        confirmationView.frame = view.bounds
        confirmationView.isOpaque = false
        
        view.addSubview(confirmationView)
        view.isUserInteractionEnabled = false
        
        confirmationView.showDialog()
        
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"

        let date = dateFormatter.string(from: Date())

        let location = Location(locationName: locationNameTextField.text ?? "Title", description: locationDescriptionTextView.text, date: date)
        
        locationStore.addLocation(location)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? ViewController else { return }
//
//        // Format date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YY/MM/dd"
//
//        let date = dateFormatter.string(from: Date())
//
//        let location = Location(locationName: locationNameTextField.text ?? "Title", description: locationDescriptionTextView.text, date: date)
//
//        destination.locations.append(location)
//    }
}

extension MapDetailsViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            locationDescriptionTextView.resignFirstResponder()
            view.endEditing(true)
            return false
        }
        return true
    }
}

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
    @IBAction func addLocation(_ sender: Any) {
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"

        let date = dateFormatter.string(from: Date())

        let location = Location(locationName: locationNameTextField.text ?? "Title", description: locationDescriptionTextView.text, date: date)
        
        // Make sure it is not already in the list
        if !locationStore.alreadyInList(location: location) {
            locationStore.addLocation(location)
            
            let confirmationView = ConfirmationDialog()
            confirmationView.frame = view.bounds
            confirmationView.isOpaque = false
            
            view.addSubview(confirmationView)
            view.isUserInteractionEnabled = false
            
            confirmationView.showDialog()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            showAlert(withTitle: "Name taken", withMessage: "Please use a new location name")
        }

    }

    
    //MARK: - Properties
    var locationManager: CLLocationManager!
    var savedLocations = [Location]()
    var locationStore: LocationStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change map to a satellite view
        mapView.mapType = .satellite
        
        // Disable scrolling inside the map
        mapView.isScrollEnabled = false
        
        // Shows the users current location on the map.
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        
        // Dismiss the keyboard when tapping somewhere other than the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // Alert for if the user uses a pre existing name
    func showAlert(withTitle title: String, withMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
            [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert,animated: true)
    }
    
    // MARK: - Keyboard
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

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

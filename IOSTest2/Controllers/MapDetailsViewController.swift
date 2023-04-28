//
//  MapDetailsViewController.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-24.
//

import UIKit
import MapKit

class MapDetailsViewController: UIViewController, CLLocationManagerDelegate  {
    
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

        // Set the location object
        let location = Location(locationName: locationNameTextField.text ?? "Title", description: locationDescriptionTextView.text, date: date)
        
        // Make sure it is not already in the list
        if !locationStore.alreadyInList(location: location) {
            locationStore.addLocation(location)
            
            // Start confirmation animation
            let confirmationView = ConfirmationDialog()
            confirmationView.frame = view.bounds
            confirmationView.isOpaque = false
            
            view.addSubview(confirmationView)
            view.isUserInteractionEnabled = false
            
            // Show animation
            confirmationView.showDialog()
            
            // Change to map view controller
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            // Display an alert if the name is already taken.
            showAlert(withTitle: "Name taken", withMessage: "Please use a new location name")
        }

    }

    
    //MARK: - Properties
    var locationManager = CLLocationManager()
    var savedLocations = [Location]()
    var locationStore: LocationStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change map to a satellite view
        mapView.mapType = .satellite
        
        // Disable scrolling on the map
        mapView.isScrollEnabled = false
        
        locationManager.delegate = self
        
        // Dismiss the keyboard when tapping somewhere other than the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - Location functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Set the maps region view to the users location
        let mUserLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
        mapView.setRegion(mRegion, animated: true)
        
        // Get users current location
        guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        // Create pin
        createPin(currentLocation: currentLocation)
    }
    
    // Create pin with users current location
    func createPin(currentLocation: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = currentLocation
        mapView.addAnnotation(pin)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
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

extension MapDetailsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationNameTextField.resignFirstResponder()
        return true
    }
}

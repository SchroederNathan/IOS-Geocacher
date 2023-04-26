//
//  MapDetailsViewController.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-24.
//

import UIKit
import MapKit

class MapDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationNameTextField: UITextField!
    @IBOutlet var locationDescriptionTextView: UITextView!
    
    //MARK: - Actions
    @IBAction func addLocation(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "LocationsVC") as! ViewController
        
        
        
    }
    
    //MARK: - Properties
    var locationManager: CLLocationManager!

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

//
//  ViewController.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-19.
//

import UIKit
import MapKit
import CoreSpotlight
import MobileCoreServices

import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Diffable Data Source
    private lazy var tableDataSource = UITableViewDiffableDataSource<Section, Location>(tableView: tableView){
        tableView, IndexPath, location in
        
        // Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: IndexPath)
        
        // Change labels
        cell.textLabel?.text = location.locationName
        cell.detailTextLabel?.text = location.date
        
        print(IndexPath.row)
        
        
        self.index(item: IndexPath.row)
        
        return cell
    }
    
    // MARK: - Properties
    var locationStore: LocationStore!
    var locationManager = CLLocationManager()
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        locationManager.delegate = self
        
        // Request location
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
        
        // Update users location
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Loads data into the table view
        loadSnapshot()
    }
    
    // Index through each in the location list to make it visible in spotlight search
    func index(item: Int) {
        let location = locations[item]

        // Set attributes for spotlight search
        let attributeSet = CSSearchableItemAttributeSet(contentType: .text)
        attributeSet.title = location.locationName
        attributeSet.contentDescription = location.description
        attributeSet.thumbnailData = UIImage(systemName: "backpack.fill")?.withTintColor(.white).pngData()
        
        print("\(location.locationName ?? "none")")

        let item = CSSearchableItem(uniqueIdentifier: "\(item)", domainIdentifier: "dev.nathanschroeder", attributeSet: attributeSet)
        
        // Make sure the item doesnt expire after the default amount
        item.expirationDate = Date.distantFuture
        
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
        
    }
    
    // Re-populates the locations array and table when the view appears
    override func viewWillAppear(_ animated: Bool) {
        locations = locationStore.allLocations
        loadSnapshot()
    }
    
    // Loads all location data required for the tableview
    func loadSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        snapshot.appendSections([.main])
        snapshot.appendItems(locationStore.allLocations, toSection: .main)
        tableDataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    // Alert for when user taps on an item in the spotlight search
    func showAlert(_ which: Int) {
        let alert = UIAlertController(title: "Do you remember?", message: "\(locations[which].locationName ?? "Title") \n \(locations[which].description ?? "Description")", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MapDetailsViewController else { return }

        // Send properties to the MapDetailsViewController
        destination.locationStore = locationStore
        destination.savedLocations = locations
        destination.locationManager = locationManager
    }
    
    
    
    
    
    
}



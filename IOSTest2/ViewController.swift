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
        
        // Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        
        cell.detailTextLabel?.text = dateFormatter.string(from: location.date)
        
        return cell
    }
    
    // MARK: - Properties
    
    var locationManager = CLLocationManager()
    var locations = [Location]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // Request location
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        let defaults = UserDefaults.standard
        if let savedLocations = defaults.object(forKey: "locations") as? [Location] {
            locations = savedLocations
        }
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        
        
        loadSnapshot()
    }
    
    func index(item: Int) {
        let location = locations[item]

        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = location.locationName
        attributeSet.contentDescription = location.description
        attributeSet.addedDate = location.date

        let item = CSSearchableItem(uniqueIdentifier: "\(item)", domainIdentifier: "dev.nathanschroeder", attributeSet: attributeSet)
        item.expirationDate = Date.distantFuture
        
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
        
        
    }
    
    func loadSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        snapshot.appendSections([.main])
        snapshot.appendItems(locations, toSection: .main)
        tableDataSource.apply(snapshot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MapDetailsViewController else { return }
        
        destination.locationManager = locationManager
    }
    
    
    
    
    
    
}



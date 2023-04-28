//
//  LocationStore.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-26.
//

import Foundation

class LocationStore {
    
    // MARK: - properties
    private var locationList = [Location]()
    
    // Returns array of all locations
    var allLocations: [Location] {
        return locationList
    }
        
    // Takes in a location object and adds it to the array
    func addLocation(_ location: Location) {
        locationList.append(location)
        saveLocations()
    }
    
    //determine the document library
    var documentLibrary: URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(paths[0])
        
        return paths[0]
    }
    
    // Check if the movie is already in the list
    func alreadyInList(location: Location) -> Bool {
        if locationList.contains(location) {
            return true
        } else {
            return false
        }
    }
    
    // Saves locations to the document directory
    func saveLocations(){
        if let fileLocation = documentLibrary?.appendingPathComponent("locations.json"){
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                let jsonData = try encoder.encode(locationList)
                
                // Write data to document directory
                try jsonData.write(to: fileLocation)
            } catch {
                print("Error - could not save: \(error.localizedDescription)")
            }
        }
    }
    
    // Loads locations from the document directory
    func loadLocations(){
        // Get file path
        if let fileLocation = documentLibrary?.appendingPathComponent("locations.json"){
            do{
                let jsonData = try Data(contentsOf: fileLocation)
                
                let decoder = JSONDecoder()
                
                // Save data to location array
                locationList = try decoder.decode([Location].self, from: jsonData)
            }catch {
                print("Unable to load the JSON - \(error.localizedDescription)")
            }
        }
    }

}

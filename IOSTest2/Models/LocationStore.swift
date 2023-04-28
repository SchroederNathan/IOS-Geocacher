//
//  LocationStore.swift
//  IOSTest2
//
//  Created by Nathan Schroeder on 2023-04-26.
//

import Foundation

class LocationStore {
    
    private var locationList = [Location]()
    
    var allLocations: [Location] {
        return locationList
    }
        
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
    
    func saveLocations(){
        if let fileLocation = documentLibrary?.appendingPathComponent("locations.json"){
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                let jsonData = try encoder.encode(locationList)
                
                try jsonData.write(to: fileLocation)
            } catch {
                print("Error - could not save: \(error.localizedDescription)")
            }
        }
    }
    
    func loadLocations(){
        if let fileLocation = documentLibrary?.appendingPathComponent("locations.json"){
            do{
                let jsonData = try Data(contentsOf: fileLocation)
                
                let decoder = JSONDecoder()
                locationList = try decoder.decode([Location].self, from: jsonData)
            }catch {
                print("Unable to load the JSON - \(error.localizedDescription)")
            }
        }
    }

}

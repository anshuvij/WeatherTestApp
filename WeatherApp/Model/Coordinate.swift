//
//  Coordinate.swift
//  Weatherly
//
//  Created by Anshu Vij on 2/8/21.
//

import Foundation

struct Coordinate {
    
    let latitude : Double
    let longitude : Double
    
    init(dictonary : [String:Any]) {
        self.latitude = dictonary["latitude"] as? Double ?? 0.0
        self.longitude = dictonary["longitude"] as? Double ?? 0.0
    }
}

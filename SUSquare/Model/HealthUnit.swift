//
//  HealthUnit.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class HealthUnit{
    
    let unitName : String?
    let lat : Double?
    let lng : Double?
    let location : CLLocationCoordinate2D?
    let address : Address
    
    init(json: JSON) {
        self.unitName = json["nomeFantasia"].string
        self.lat = json["lat"].double
        self.lng = json["long"].double
        if let lat = lat, let lng = lng {
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        } else {
            self.location = nil
        }
        self.address = Address(json: json)
    }
}

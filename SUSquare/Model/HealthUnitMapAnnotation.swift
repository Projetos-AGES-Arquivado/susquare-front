//
//  HealthUnitMapAnnotation.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit
import MapKit

class HealthUnitMapAnnotation:NSObject, MKAnnotation {
    
    var name: String
    var title: String?
    var desc: String?
    var coordinate: CLLocationCoordinate2D
    var healthUnit: HealthUnit?
    
    convenience init(name: String, coordinate: CLLocationCoordinate2D) {
        self.init(name: name, description: nil, coordinate: coordinate, healthUnit: nil)
    }
    
    convenience init(healthUnit: HealthUnit) {
        var coordinate = kCLLocationCoordinate2DInvalid
        if let lat = healthUnit.lat, let long = healthUnit.lng {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        self.init(name: healthUnit.unitName!, description: healthUnit.address.city, coordinate: coordinate, healthUnit: healthUnit)
    }
    
    init(name: String, description: String?, coordinate: CLLocationCoordinate2D, healthUnit: HealthUnit?) {
        self.name = name
        self.desc = description
        self.coordinate = coordinate
        self.title = name
        self.healthUnit = healthUnit
    }
    
}

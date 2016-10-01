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
    
    convenience init(name: String, coordinate: CLLocationCoordinate2D) {
        self.init(name: name, description: nil, coordinate: coordinate)
    }
    
    convenience init(healthUnit: HealthUnit) {
        let coordinate = CLLocationCoordinate2D(latitude: healthUnit.lat!, longitude: healthUnit.lng!)
        self.init(name: healthUnit.unitName!, description: healthUnit.address.city, coordinate: coordinate)
    }
    
    init(name: String, description: String?, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.desc = description
        self.coordinate = coordinate
        self.title = name
    }
    
}

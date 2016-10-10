//
//  User.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 08/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import DigitsKit
import CoreLocation

class User {
    
    static let sharedInstance = User()
    
    var session : String?
    var location : CLLocationCoordinate2D?
}

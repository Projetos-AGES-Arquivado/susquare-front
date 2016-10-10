//
//  User.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 08/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import DigitsKit
import MapKit

class User {
    
    static let sharedInstance = User()
    var location : CLLocationCoordinate2D?
    var session : DGTSession? {
        set {
            if (newValue != nil) {
                AuthenticationManager.sharedInstance.saveUserSession(session: newValue!)
            } else {
                NSLog("session set value shouldnt be nil, otherwise the session will not be ssaved on the UserDefaults")
            }
        } get {
            return AuthenticationManager.sharedInstance.getUserSession()
        }
    }
}

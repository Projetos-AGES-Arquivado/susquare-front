//
//  User.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 08/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import DigitsKit

class User {
    
    static let sharedInstance = User()
    
    var session : DGTSession? {
        set {
            AuthenticationManager.sharedInstance.saveUserSession(session: session!)
        } get {
            return AuthenticationManager.sharedInstance.getUserSession()
        }
    }
}

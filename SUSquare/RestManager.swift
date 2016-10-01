//
//  RestManager.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import CoreLocation

class RestManager {
    
    static let sharedInstance = RestManager()
    
    let apiUrl = "http://10.32.223.6/susquare/api"
    
    let getEstablishment = "/estabelecimentos"
    
    func requestEstablishment(byLocation location: CLLocationCoordinate2D, withRange range: Int){
        let parameters = ["latitude": location.latitude,"longitude": location.longitude,"raio": range] as [String : Any]
        
        
    }
}

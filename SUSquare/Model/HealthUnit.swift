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
    let category : String?
    var services = [String:String]()
    let schedule : String?
    let address : Address
    var distance : Int?
    
    init(json: JSON) {
        self.unitName = json["nomeFantasia"].string
        self.lat = json["lat"].double
        self.lng = json["long"].double
        if let lat = lat, let lng = lng {
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        } else {
            self.location = nil
        }
        self.services["temAtendimentoUrgencia"] = json["temAtendimentoUrgencia"].string
        self.services["temAtendimentoAmbulatorial"] = json["temAtendimentoAmbulatorial"].string
        self.services["temCentroCirurgico"] = json["temCentroCirurgico"].string
        self.services["temObstetra"] = json["temObstetra"].string
        self.services["temNeoNatal"] = json["temNeoNatal"].string
        self.services["temDialise"] = json["temDialise"].string
        self.category = json["tipoUnidade"].string
        self.schedule = json["turnoAtendimento"].string
        self.address = Address(json: json)
    }
    
    func calcDistanceToUser(){
        if let location = User.sharedInstance.location {
            let unitLocation = CLLocation(latitude: (self.location?.latitude)!, longitude: (self.location?.longitude)!)
            let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
            let distanceInMeters = Int((unitLocation.distance(from: userLocation)))
            
            let distanceInKilometers = distanceInMeters/1000
            
            print("IN M: \(distanceInMeters) ----- IN KM:\(distanceInKilometers)")
            
            self.distance = distanceInKilometers
        }
    }
}

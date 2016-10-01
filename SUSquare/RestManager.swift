//
//  RestManager.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class RestManager {
    
    static let sharedInstance = RestManager()
    
    let apiUrl = "http://10.32.223.6/susquare/api"
    
    let getEstablishment = "/estabelecimentos"
    
    func requestEstablishment(byLocation location: CLLocationCoordinate2D, withRange range: Int){
        let parameters = ["latitude": location.latitude,"longitude": location.longitude,"raio": range] as [String : Any]
        
        let url = apiUrl.appending(getEstablishment)
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

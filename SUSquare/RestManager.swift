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


typealias HealthUnitResponseBlock = (_ response: [HealthUnit]?, _ error: Error?) -> ()
class RestManager {
    
    static let sharedInstance = RestManager()
    
    //LOCAL
//    let apiUrl = "localhost:8888"
    
    //DEV
//    let apiUrl = "http://10.32.223.6/susquare/api"
    
    
    //HOMO
//    let apiUrl = "http://www.homo.ages.pucrs.br/susquare"
    
    
    //PROD
    let apiUrl = "http://www.ages.pucrs.br/susquare"
    
    let getHealthUnits = "/estabelecimentos"
    
    
    func requestHealthUnits(byLocation location: CLLocationCoordinate2D,
                              withRange range: Int,
                              withBlock block: @escaping HealthUnitResponseBlock) {
        
        let parameters = ["latitude": location.latitude,"longitude": location.longitude,"raio": range] as [String : Any]
        
        let url = apiUrl.appending(getHealthUnits)
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsons = JSON(value)
                var allUnits: [HealthUnit] = [HealthUnit]()
                for json in jsons {
                    allUnits += [HealthUnit(json: json.1)]
                }
                
                block(allUnits, nil)
            case .failure(let error):
                block(nil, error)
                print(error)
            }
        }
    }
}

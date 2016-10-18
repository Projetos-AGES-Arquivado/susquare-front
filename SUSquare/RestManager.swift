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
    
    //PROD
    let apiUrl = "http://www.ages.pucrs.br/susquare"
    let metamodeloUrl = "http://mobile-aceite.tcu.gov.br/appCivicoRS/rest"
    
    
    let signUpUser = "/pessoas"
    let authenticateUser = "/pessoas/autenticar"
    
    let getHealthUnits = "/estabelecimentos"
    
    let appIdentifier = "348"
    
    func requestHealthUnits(byLocation location: CLLocationCoordinate2D,
                              withRange range: Int,
                              withParameters params: [String: String]? = nil,
                              withBlock block: @escaping HealthUnitResponseBlock) {
        
        let a = "/estabelecimentos/latitude/\(location.latitude)/longitude/\(location.longitude)/raio/\(range)"
        
        var parameters = [String: Any]()
        
        if let params = params {
            for param in params {
                parameters[param.key] = param.value
            }
        }
        
        let url = apiUrl.appending(a)
        
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
    
    func signUp(_ username : String, _ email : String, _ password : String,block: @escaping ()->()){
        let parameters = ["nomeUsuario":username,"email":email,"senha":password]
        
        Alamofire.request("\(metamodeloUrl)\(signUpUser)", method: .post, parameters: parameters,encoding: JSONEncoding.default).responseString { (response) in
            print(response)
            block()
        }
    }
    
    func authenticateUser(_ email : String, _ password : String){
        let parameters = ["email":email,"senha":password]
        Alamofire.request("\(metamodeloUrl)\(authenticateUser)", method: .get, headers: parameters).responseJSON { (response) in
            
            let json = JSON(response.result.value)
            User.sharedInstance.codAutor = "\(json["cod"].int))"
        }
    }
}

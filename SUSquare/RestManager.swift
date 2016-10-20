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
    
    //LOCAL
//    let apiUrl = "localhost:8888"
    
    //DEV
//    let apiUrl = "http://10.32.223.6/susquare/api"
    
    
    //HOMO
    static let baseURL = "http://mobile-aceite.tcu.gov.br/mapa-da-saude/rest"
    
    
    //PROD
//    let apiUrl = "http://www.ages.pucrs.br:3000/susquare"
    
//    let apiUrl = "http://susquare-api.herokuapp.com"
    
    static let getHealthUnits = "/estabelecimentos"
    
    static let signUpUser = "/pessoas"
    static let authenticateUser = "/pessoas/autenticar"
    
    
    static let appIdentifier = "348"
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90 // seconds
        configuration.timeoutIntervalForResource = 90
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static func requestHealthUnits(byLocation location: CLLocationCoordinate2D?,
                              withRange range: Int,
                              withParameters params: [String: Any]? = nil,
                              withBlock block: @escaping HealthUnitResponseBlock) {
        if let location = location {
            //Aqui deve ser feito o request baseado na localizacão
            let a = "/estabelecimentos/latitude/\(location.latitude)/longitude/\(location.longitude)/raio/\(range)"
            print(a)
        } else {
            //Aqui deve ser feito o request sem location
        }

        
        var parameters = [String: Any]()
        
        if let params = params {
            for param in params {
                parameters[param.key] = param.value
            }
        }
        
        let url = baseURL.appending(getHealthUnits)
        
        manager.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
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
    
    static func signUp(_ username : String, _ email : String, _ password : String,block: @escaping ()->()){
        let parameters = ["nomeUsuario": username,"email": email,"senha": password]
        let url = baseURL.appending(signUpUser)
        manager.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default).responseString { (response) in
            print(response)
            block()
        }
    }
    
    static func authenticateUser(_ email : String, _ password : String){
        let parameters = ["email": email,"senha": password]
        let url = baseURL.appending(authenticateUser)
        
        manager.request(url, method: .get, headers: parameters).responseJSON { (response) in
            
            let json = JSON(response.result.value)
            User.sharedInstance.codAutor = "\(json["cod"].int))"
        }
    }
}

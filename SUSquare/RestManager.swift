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
    
    
    //HOMO
    static let baseURLMapadasaude = "http://mobile-aceite.tcu.gov.br/mapa-da-saude/rest"
    static let baseURLMetamodelo = "http://mobile-aceite.tcu.gov.br/appCivicoRS/rest"
    
    
    //HOMO
    static let baseURL = "http://mobile-aceite.tcu.gov.br/mapa-da-saude/rest"
    
    static let getHealthUnits = "/estabelecimentos"
    static let signUpUser = "/pessoas"
    static let authenticateUser = "/pessoas/autenticar"
    static let createAttendance = "/postagens/conteudos"
    
    static let posts = "/postagens"
    static let postsSteps = "/conteudos"
    
    static let appIdentifier = "348"
    static let tipoPostagemAtendimento = "221"
    
    static var idAtendimento = ""
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90 // seconds
        configuration.timeoutIntervalForResource = 90
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static let managerWithValidation: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90 // seconds
        configuration.timeoutIntervalForResource = 90
        configuration.httpAdditionalHeaders = ["appToken":User.sharedInstance.appToken,"appIdentifier":appIdentifier]
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static func requestHealthUnits(byLocation location: CLLocationCoordinate2D?,
                                   withRange range: Int?,
                                   withParameters params: [String: Any]? = nil,
                                   withBlock block: @escaping HealthUnitResponseBlock) {
        
        var parameters = [String: Any]()
        
        if let params = params {
            for param in params {
                parameters[param.key] = param.value
            }
        }
        
        
        var url = baseURLMapadasaude.appending(getHealthUnits)
        
        if let location = location, let range = range {
            let getHealthUnitsWithText = "/estabelecimentos/latitude/\(location.latitude)/longitude/\(location.longitude)/raio/\(range)"
            url = baseURL.appending(getHealthUnitsWithText)
        } else {
            url = baseURL.appending(getHealthUnits)
        }
        
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
        let url = baseURLMetamodelo.appending(signUpUser)
        //        let url = baseURL.appending(signUpUser)
        manager.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default).responseString { (response) in
            block()
        }
    }
    
    static func authenticateUser(_ email : String, _ password : String){
        let parameters = ["email": email,"senha": password]
        let url = baseURLMetamodelo.appending(authenticateUser)
        
        manager.request(url, method: .get, headers: parameters).responseJSON { (response) in
            User.sharedInstance.appToken = response.response?.allHeaderFields["appToken"]! as? String
            let json = JSON(response.result.value!)
            if let cod = json["cod"].int{
                User.sharedInstance.codAutor = cod
            }
        }
    }
    
    static func createFavoriteId(){
        let parameters = ["autor": ["codPessoa":User.sharedInstance.codAutor],"tipo": ["codTipoPostagem":220]]
        let url = baseURLMetamodelo.appending(posts)
        
        let h = ["appToken": User.sharedInstance.appToken!, "appIdentifier": appIdentifier]
        
        manager.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: h).responseJSON { (response) in
                            if let stringLocation = response.response?.allHeaderFields["Location"] as? String {
                                let start = stringLocation.index(stringLocation.startIndex, offsetBy: 59)
                                let end = stringLocation.endIndex
                                let range = start..<end
                                
                                let subStringLocation = stringLocation.substring(with: range)
                                User.sharedInstance.favoriteId = subStringLocation
                            }
        }
    }
    
    
    
    static func createAttendance(_ healthUnitCode : String, _ deviceModel : String, deviceOsVersion : String){
        
        let conteudo = ["codUnidade":healthUnitCode,
                        "dispositivoModelo":deviceModel,
                        "dispositivoMarca":"Apple",
                        "dispositivoSisOp":"iOS",
                        "dispositivoSisOpVersao":deviceOsVersion]
        
        let jsonConteudoData = try! JSONSerialization.data(withJSONObject: conteudo, options: .prettyPrinted)
        
        //        print(JSONSerialization.isValidJSONObject(conteudo))
        
        let jsonString = NSString(data: jsonConteudoData, encoding: String.Encoding.utf8.rawValue) as! String
        //        print(jsonString)
        
        if let codAutor = User.sharedInstance.codAutor,
            let latitude = User.sharedInstance.location?.latitude,
            let longitude = User.sharedInstance.location?.longitude {
            
            let jsonBody : [String:Any] = ["conteudo":["JSON":jsonString],
                                           "postagem":["autor":["codPessoa":codAutor],
                                                       "latitude":latitude,
                                                       "longitude":longitude,
                                                       "tipo":["codTipoPostagem":tipoPostagemAtendimento]
                ]
            ]
            
            let url = baseURLMetamodelo.appending(createAttendance)
            
            let h = ["appToken": User.sharedInstance.appToken!, "appIdentifier": appIdentifier]
            
            managerWithValidation.request(url,
                                          method: HTTPMethod.post,
                                          parameters: jsonBody,
                                          encoding: JSONEncoding.default,
                                          headers: h).responseJSON(completionHandler: { (response) in
                                            if let stringLocation = response.response?.allHeaderFields["Location"] as? String{
                                                let start = stringLocation.index(stringLocation.startIndex, offsetBy: 59)
                                                let end = stringLocation.index(stringLocation.endIndex, offsetBy: -15)
                                                let range = start..<end
                                                
                                                let subStringLocation = stringLocation.substring(with: range)
                                                RestManager.idAtendimento = subStringLocation
                                            }
                                          })
        }
    }
    
    static func attendanceProcess(info : String){
        let conteudo : [String:Any]  = ["descricao":info,
                                        "cliente_timestamp":Date().description,
                                        "latitude":User.sharedInstance.location?.latitude,
                                        "longitude":User.sharedInstance.location?.longitude]  as [String : Any]
        
        let jsonConteudoData = try! JSONSerialization.data(withJSONObject: conteudo, options: .prettyPrinted)
        
        let jsonString = NSString(data: jsonConteudoData, encoding: String.Encoding.utf8.rawValue) as! String
        
        let parameters = ["JSON": jsonString]
        
        var url = baseURLMetamodelo.appending(posts)
        
        url = url.appending("/")
        
        url = url.appending(RestManager.idAtendimento)
        
        url = url.appending(postsSteps)
        
        let h = ["appToken": User.sharedInstance.appToken!, "appIdentifier": appIdentifier]
        
        managerWithValidation.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: h).responseString { (response) in
            print(response)
        }
    }
    
    static func attendanceCheckout(){
        let conteudo : [String:Any] = ["descricao":"checkout",
                                       "cliente_timestamp":Date().description,
                                       "checkOutMetodo":"gps",
                                       "latitude":User.sharedInstance.location?.latitude,
                                       "longitude":User.sharedInstance.location?.longitude]  as [String : Any]
        
        let jsonConteudoData = try! JSONSerialization.data(withJSONObject: conteudo, options: .prettyPrinted)
        
        let jsonString = NSString(data: jsonConteudoData, encoding: String.Encoding.utf8.rawValue) as! String
        
        let parameters = ["JSON": jsonString]
        
        var url = baseURLMetamodelo.appending(posts)
        
        url = url.appending("/")
        
        url = url.appending(RestManager.idAtendimento)
        
        url = url.appending(postsSteps)
        
        let h = ["appToken": User.sharedInstance.appToken!, "appIdentifier": appIdentifier]
        
        managerWithValidation.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: h).responseString { (response) in
            print(response)
        }
    }
}

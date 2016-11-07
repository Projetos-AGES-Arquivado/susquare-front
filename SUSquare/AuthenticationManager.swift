//
//  AuthenticationManager.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 08/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import DigitsKit

class AuthenticationManager {
    
    static let sharedInstance = AuthenticationManager()
    static let authTokenKey = "authToken"
    static let authTokenSecretKey = "authTokenSecret"
    static let userIDKey = "userID"
    static let phoneNumberKey = "phoneNumber"
    static let codAutor = "codAutor"
    static let appToken = "appToken"
    
    func saveCodAutor(codAutor: Int){
        let defaults = UserDefaults.standard
        defaults.set(codAutor, forKey: AuthenticationManager.codAutor)
    }
    
    func saveAppToken(appToken: String){
        let defaults = UserDefaults.standard
        defaults.set(appToken, forKey: AuthenticationManager.appToken)
    }
    
    func saveUserSession(session: DGTSession){
        let defaults = UserDefaults.standard
        defaults.set(session.authToken, forKey: AuthenticationManager.authTokenKey)
        defaults.set(session.authTokenSecret, forKey: AuthenticationManager.authTokenSecretKey)
        defaults.set(session.userID, forKey: AuthenticationManager.userIDKey)
        defaults.set(session.phoneNumber, forKey: AuthenticationManager.phoneNumberKey)
    }
    
    
    func getCodAutor() -> Int?{
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: AuthenticationManager.codAutor)
    }
    
    func getAppToken() -> String{
        let defaults = UserDefaults.standard
        if let appToken = defaults.string(forKey: AuthenticationManager.appToken){
            return appToken
        } else {
            return ""
        }
    }
    
    //If if fails to get the sessin aprameters fromo UserDefaults, it will return nil
    func getUserSession() -> DGTSession? {
        let defaults = UserDefaults.standard
        if let authToken = defaults.string(forKey: AuthenticationManager.authTokenKey),
            let authTokenSecret = defaults.string(forKey: AuthenticationManager.authTokenSecretKey),
            let userID = defaults.string(forKey: AuthenticationManager.userIDKey),
            let phoneNumber = defaults.string(forKey: AuthenticationManager.phoneNumberKey) {
            return DGTSession(authToken: authToken ,
                              authTokenSecret: authTokenSecret ,
                              userID: userID ,
                              phoneNumber: phoneNumber )
        } else {
            return nil
        }
    }
}

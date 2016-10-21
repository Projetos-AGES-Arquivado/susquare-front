//
//  Address.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import SwiftyJSON

class Address{
    
    let street : String?
    let number : String?
    let neighbourhood : String?
    let city : String?
    let state : String?
    let zip : Int?
    
    init(json: JSON){
        self.street = json["logradouro"].string
        self.number = json["numero"].string
        self.neighbourhood = json["bairro"].string
        self.city = json["cidade"].string
        self.state = json["uf"].string
        self.zip = json["cep"].int
    }
}

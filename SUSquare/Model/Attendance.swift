//
//  Attendance.swift
//  SUSquare
//
//  Created by AGES on 21/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import Foundation
import SwiftyJSON

class Attendance {
    
    var codUnidade : String?
    var dispositivoModelo   : String?
    var dispositivoMarca : String?
    var dispositivoSisOp : String?
    var dispositivoSisOpVersao : String?
    
    init(json: JSON){
        self.codUnidade = json["codUnidade"].string
        self.dispositivoModelo = json["dispositivoModelo"].string
        self.dispositivoMarca = json["dispositivoMarca"].string
        self.dispositivoSisOp = json["dispositivoSisOp"].string
        self.dispositivoSisOpVersao = json["dispositivoSisOpversao"].string
    }
}

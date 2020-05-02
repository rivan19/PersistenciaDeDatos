//
//  CharacterModel.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

class Character : Codable {
    let name : String
    let image : String?
    let descripcion : String?
    let power : Int?
    let kind: String
    
    init (name: String, image: String?, descripcion: String?, power: Int?, kind: String) {
        
        self.name = name
        self.image = image ?? ""
        self.descripcion = descripcion ?? ""
        self.power = power ?? 0
        self.kind = kind
    }
}



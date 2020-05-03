//
//  CharacterModel.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 01/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

class Character : Codable {
    let id: Int
    let name : String
    let image : String?
    let power : Int
    let descripcion : String?
    let kind: String
    
    init (id: Int, name: String, image: String?, descripcion: String?, power: Int?, kind: String) {
        self.id = id
        self.name = name
        self.image = image ?? ""
        self.descripcion = descripcion ?? ""
        self.power = power ?? 0
        self.kind = kind
    }
}



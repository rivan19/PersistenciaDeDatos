//
//  DataProvider.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 02/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import Foundation

class DataProvider {
    
    private var database: Database? = nil
    
    init() {
        database = Database()
    }
    
    deinit {
        database = nil
    }
    
    func createAvenger() -> Avengers? {
        return database?.createDataAvenger() as? Avengers
    }
    
    func createVillain() -> Villains? {
        return database?.createDataVillains() as? Villains
    }
    
    func createBattle() -> Battles? {
        return database?.createDataVillains() as? Battles
    }
    
    func save() {
        database?.persist()
    }
    
    func deleteAvenger(avenger: Avengers) {
        database?.delete(data: [avenger])
    }
    
    func deleteVillains(villain: Villains) {
        database?.delete(data: [villain])
    }
    
    func deleteBattles(battle: Battles) {
        database?.delete(data: [battle])
    }
    
    func loadAllEntitie(entitie: KindEntity) -> [Any] {
        
        guard let data = database?.fecthAllData(entitie: entitie) else {
            return []
        }
        
        switch entitie {
        case .avenger:
            return data as? [Avengers] ?? []
        case .villain:
            return data as? [Villains] ?? []
        case .battle:
            return data as? [Battles] ?? []
        }
    }
    
    func loadBy(entitie: KindEntity, id: Int) -> [Any] {
        
        guard let data = database?.fetchDataBy(id: id, entitie: entitie) else {
            return []
        }
        
        switch entitie {
        case .avenger:
            return data as? [Avengers] ?? []
        case .villain:
            return data as? [Villains] ?? []
        case .battle:
            return data as? [Battles] ?? []
        }
        
    }
}

//
//  Utilities.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 02/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit
import CoreData

//MARK: Protocols
protocol SelectedCharacterDelegate : class {
    func selectedCharacter(character: Character)
}

protocol EditPowerViewDelegate: AnyObject {
    func onPowerSaved(entitie: KindEntity, id: Int, esSuperHeroe: Bool)
}

protocol EditCharacterDelegate: class {
    func onCharacterSaved()
}

//MARK: Enums
enum KindSuperHeroe : String {
    case avenger = "A"
    case villain = "V"
}

enum KindEntity : String {
    case avenger = "Avengers"
    case villain = "Villains"
    case battle = "Battles"
}

class Utilities {
    
    static var shared = Utilities()
    private init() {}
    let segue_Avenger = "SEGUE_HEROES_DETAIL"
    let segue_Villain = "SEGUE_VILLAIN_DETAIL"
    let segue_edit_Power = "SEGUE_EDIT_POWER"
    let segue_detail_battle = "SEGUE_SHOW_DETAIL_BATTLE"
    
    let key_user_default = "keyUserDefaultPersistence"
    let key_last_view = "keyUserDefaultView"
    
    let maxPower: Int = 5
    
    private var avengersModel: [Character] = []
    private var villainsModel: [Character] = []
    
    private var dataProvider = DataProvider()
    
    func getImageSuperPower(power: Int) -> String {
        return "ic_stars_\(power)"
    }
    
    func setupDataModelVillain(){
        if let pathURL = Bundle.main.url(forResource: "villains", withExtension: "json"){
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                villainsModel = try decoder.decode([Character].self, from: data)

            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not build the path url for Episode")
        }
        
    }
    
    func setupDataModelAvenger(){
        if let pathURL = Bundle.main.url(forResource: "avengers", withExtension: "json"){
            do {
                let data = try Data.init(contentsOf: pathURL)
                let decoder = JSONDecoder()
                avengersModel = try decoder.decode([Character].self, from: data)
                

            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not build the path url for Episode")
        }
        
    }
    
    func saveDataModel() {
        setupDataModelAvenger()
        setupDataModelVillain()
        
        saveDataModelAvengers()
        saveDataModelVillan()
        
        saveUserDefault(value: "S", key: key_user_default)
    }
    
    func saveDataModelVillan() {
        villainsModel.forEach { (villain) in
            guard let villains = dataProvider.createVillain() else {
                return
            }
            
            villains.descripcion = villain.descripcion
            villains.id = Int32(villain.id)
            villains.image = villain.image
            villains.name = villain.name
            villains.power = Int32(villain.power)
            
        }
        
        dataProvider.save()
    }
    
    func saveDataModelAvengers() {
        avengersModel.forEach { (avenger) in
            guard let avengers = dataProvider.createAvenger() else {
                return
            }
            
            avengers.descripcion = avenger.descripcion
            avengers.id = Int32(avenger.id)
            avengers.image = avenger.image
            avengers.name = avenger.name
            avengers.power = Int32(avenger.power)
        }
        
        dataProvider.save()
    }
    
    func getVillains() -> [Villains] {
        guard let data = dataProvider.loadAllEntitie(entitie: .villain) as? [Villains] else
        {
            return []
        }
        return data
    }
    
    func getDataVillain() -> [Villains] {
        let values = getUserDefault(key: key_user_default)
        if values != "S" {
            saveDataModel()
        }
        
        return getVillains()
    }
    
    func getAvengers() -> [Avengers] {
        guard let data = dataProvider.loadAllEntitie(entitie: .avenger) as? [Avengers] else
        {
            return []
        }
        
        return data
    }
    
    func getDataAvengers() -> [Avengers] {
        let values = getUserDefault(key: key_user_default)
        if values != "S" {
            saveDataModel()
        }
        
        return getAvengers()
    }
    
    func getBattles() -> [Battles] {
        guard let data = dataProvider.loadAllEntitie(entitie: .battle) as? [Battles] else {
            return []
        }
        
        return data
    }
    
    func saveUserDefault(value: String, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getUserDefault(key: String) -> String{
        return UserDefaults.standard.string(forKey: key) ?? ""
    }

}

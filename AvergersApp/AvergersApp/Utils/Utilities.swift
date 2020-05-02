//
//  Utilities.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 02/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

//MARK: Protocols
protocol SelectedCharacterDelegate : class {
    func selectedCharacter(character: Character)
}


//MARK: Enums
enum KindSuperHeroe : String {
    case avenger = "A"
    case villain = "V"
}



class Utilities {
    
    static var shared = Utilities()
    private init() {}
    let segue_Avenger = "SEGUE_HEROES_DETAIL"
    let segue_Villain = "SEGUE_VILLAIN_DETAIL"
    
    func getImageSuperPower(power: Int) -> String {
        return "ic_stars_\(power)"
    }

}

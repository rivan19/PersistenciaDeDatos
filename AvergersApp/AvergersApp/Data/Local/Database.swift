//
//  Database.swift
//  AvergersApp
//
//  Created by Ivan Llopis Guardado on 02/05/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit
import CoreData

class Database {
    private let entityAvengers = "Avengers"
    private let entityVillains = "Villains"
    private let entityBattles = "Battles"
    
    private let propertyId = "id"
    private let propertyName = "name"
    private let propertyDescripcion = "descripcion"
    private let propertyImage = "image"
    private let propertyPower = "power"
    private let propertyWin = "win"
    
    private func context() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
         
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Database methods
    func createDataAvenger() -> NSManagedObject? {
        guard let contextMOB = context(),
              let entity = NSEntityDescription.entity(forEntityName: entityAvengers,
                                                      in: contextMOB) else {
            return nil
        }
        
        return Avengers(entity: entity,
                    insertInto: context())
    }
    
    func createDataVillains() -> NSManagedObject? {
        guard let contextMOB = context(),
              let entity = NSEntityDescription.entity(forEntityName: entityVillains,
                                                      in: contextMOB) else {
            return nil
        }
        
        return Villains(entity: entity,
                        insertInto: context())
    }
    
    func createDataBattles() -> NSManagedObject? {
        guard let contextMOB = context(),
              let entity = NSEntityDescription.entity(forEntityName: entityBattles,
                                                      in: contextMOB) else {
            return nil
        }
        
        return Battles(entity: entity,
                       insertInto: context())
    }
    
    func persist() {
        guard let contextMOB = context() else {
            return
        }
        
        try? contextMOB.save()
    }
    
    func fecthAllData(entitie: KindEntity) -> [NSManagedObject]? {
        
        return try? context()?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entitie.rawValue)) as? [NSManagedObject]
    }
    
    func fetchDataBy(id: Int, entitie: KindEntity) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entitie.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func delete(data: [NSManagedObject]) {
        let contextMOB = context()
        data.forEach{ contextMOB?.delete($0) }
        
        print("Deleted objects: \(String(describing: contextMOB?.deletedObjects))")
        try? contextMOB?.save()
    }
    
    
}

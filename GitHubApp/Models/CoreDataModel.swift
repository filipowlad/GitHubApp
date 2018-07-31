//
//  CoreDataModel.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit
import CoreData

class CoreDataModel {
    
    static func deleteRecords() {
        let context = getContext()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do { try context.execute(request) }
        catch { print("Failed deleting info") }
    }
    
    static func addRecord( _ value: String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(value, forKey: "token")
        
        do { try context.save() }
        catch { print("Failed saving info") }
    }
    
    static func getRecord(completion: (String?)->()) {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        var result: String?
        do {
            guard let entityObject = try context.fetch(request) as? [NSManagedObject] else {
                completion(nil)
                return
            }
            if !entityObject.isEmpty { result = entityObject[0].value(forKey: "token") as? String }
            completion(result)
        } catch {
            print("Failed getting info")
            completion(nil)
        }
    }
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

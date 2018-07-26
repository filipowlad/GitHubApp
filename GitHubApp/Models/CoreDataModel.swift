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
    static func deleteRecords(of entityName: String) -> Void {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [NSManagedObject]
        
        for object in resultData { context.delete(object) }
        
        do { try context.save() }
        catch { print("Error while saving") }
    }
    
    static func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

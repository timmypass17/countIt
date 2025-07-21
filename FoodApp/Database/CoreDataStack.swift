//
//  CoreDataStack.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import Foundation
import CoreData

// Core data not syncing? https://developer.apple.com/forums/thread/664966 see step 5, just refresh
class CoreDataStack {
    static let shared = CoreDataStack()
    
    var context: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true // important for watchos and app sync
//        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }
    
    func childContext(parentContext: NSManagedObjectContext? = CoreDataStack.shared.context) -> NSManagedObjectContext {
        let childContext = NSManagedObjectContext(.mainQueue)
        childContext.parent = parentContext
        return childContext
    }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let appGroup = "group.com.example.DuduMelon"
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)!
        let storeURL = containerURL.appendingPathComponent("FoodApp.sqlite") // FoodApp.xcdatamodeld
        let description = NSPersistentStoreDescription(url: storeURL)
        // Maybe remove?
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.example.DuduMelon")
        let container = NSPersistentCloudKitContainer(name: "FoodApp")  // FoodApp.xcdatamodeld
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension CoreDataStack {
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Success")
            } catch {
                print("Error saving: \(error)")
            }
        }
    }
}

extension CoreDataStack {
    // Decode: data -> your object
    static func decode<T: Decodable>(jsonString: String) -> T {
        let data = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    // Encode: your object -> data
    static func encode<T: Encodable>(value: T) -> String {
        let reminderData = try! JSONEncoder().encode(value)
        return String(data: reminderData, encoding:.utf8)!
    }
}

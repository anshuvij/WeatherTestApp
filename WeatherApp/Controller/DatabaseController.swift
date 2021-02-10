//
//  DatabaseController.swift
// WeatherApp
//
//  Created by Anshu Vij on 2/8/21.
//

import Foundation
import CoreData

class DatabaseController {

    private init() {}

    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }


    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "WeatherApp")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

                //TODO: - Add Error Handling for Core Data

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }


        })
        return container
    }()

    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                //You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    /* Support for GRUD Operations */

    // GET / Fetch / Requests
    class func getAllWeather() -> Array<Weather> {
        let all = NSFetchRequest<Weather>(entityName: "Weather")
        var allWeather = [Weather]()

        do {
            let fetched = try DatabaseController.getContext().fetch(all)
            allWeather = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return allWeather
    }

    
    
    // Delete ALL Weather From CoreData
      class func deleteAllWeather() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try DatabaseController.getContext().execute(deleteALL)
            DatabaseController.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }

    class func checkIfCityExist(name : String) -> Bool{
        
       var result = false
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        req.predicate = NSPredicate(format: "cityName == %@", name)
        
        do {
        
            let count =  try DatabaseController.getContext().count(for: req)
            if count == 0 {
                result = false
            }
            else
            {
                result = true
            }
        } catch {
            print ("There is an error in checkIfCityExist records")
        }
        
        return result
    
}

}






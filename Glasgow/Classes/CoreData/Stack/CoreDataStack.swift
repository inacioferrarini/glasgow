//    The MIT License (MIT)
//
//    Copyright (c) 2017 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import CoreData

/**
 The `Core Data` stack.
 */
open class CoreDataStack {
    
    
    // MARK: - Properties
    
    /**
     Name of Core Data model file.
     */
    open let modelFileName: String
    
    /**
     Name of Data Base file.
     */
    open let databaseFileName: String
    
    /**
     Bundle where the model is located.
     */
    open let bundle: Bundle?
    
    
    // MARK: - Initialization
    
    /**
     Convenience init.
     
     - parameter modelFileName: `Core Data` model file name.
     
     - parameter databaseFileName: `Core Data` database file name.
     */
    public convenience init(modelFileName: String, databaseFileName: String) {
        self.init(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: nil)
    }

    /**
     Inits the `Core Data` stack.
     
     - parameter modelFileName: `Core Data` model file name.
     
     - parameter databaseFileName: `Core Data` database file name.
     
     - parameter bundle: Bundle where `Core Data` `model file` is located.
     */
    public init(modelFileName: String, databaseFileName: String, bundle: Bundle?) {
        self.modelFileName = modelFileName
        self.databaseFileName = databaseFileName
        self.bundle = bundle
    }
    
    
    // MARK: - Lazy Helper Properties
    
    lazy var applicationDocumentsDirectory: URL? = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        var modelURL = Bundle.main.url(forResource: self.modelFileName, withExtension: "momd")
        if let bundle = self.bundle {
            modelURL = bundle.url(forResource: self.modelFileName, withExtension: "momd")
        }
        guard let url = modelURL else { return nil }
        return NSManagedObjectModel(contentsOf: url)
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let model = self.managedObjectModel else { return nil }
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        guard let documentsDirectory = self.applicationDocumentsDirectory else { return nil }
        let url = documentsDirectory.appendingPathComponent("\(self.databaseFileName).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        let isRunningUnitTests = NSClassFromString("XCTest") != nil
        let storeType = isRunningUnitTests ? NSInMemoryStoreType : NSSQLiteStoreType
        _ = try? coordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: url, options: nil)
        return coordinator
    }()
    
    /**
     The `Core Data` `ManagedObjectContext`. 
     */
    open lazy var managedObjectContext: NSManagedObjectContext? = {
        guard let coordinator = self.persistentStoreCoordinator else { return nil }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    // MARK: - Core Data Saving support
    
    /**
     Saves the `Core Data` context, if there is changes to be saved.
     
     
     ### If you do not want to handle any exception that may happen, you can use: ###
     ````
     try? coreDataStack.saveContext()
     ````
     
     
     ### If you want to handle any exception that may happen, you can use: ###
     ````
     do {
        try coreDataStack.saveContext()
     } catch let error as NSError {
        print("Error: \(error)")
     }
     ````
     */
    open func saveContext() throws {
        guard let managedObjectContext = self.managedObjectContext else { return }
        if managedObjectContext.hasChanges {
            try managedObjectContext.save()
        }
    }
    
}

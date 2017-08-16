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

import Foundation
import CoreData


/**
 A `Core Data` `DataProvider`.
 */
open class CoreDataProvider<Entity: NSManagedObject>: ArrayDataProvider<Entity>, NSFetchedResultsControllerDelegate, Refreshable {
    
    
    // MARK: - Properties
    
    /**
     The predicate to be applied to every data fetch operation.
     After changing the value, the data must be fetched again, execute `refresh()` method.
     */
    open var predicate: NSPredicate? {
        didSet {
            self.fetchedResultsController.fetchRequest.predicate = predicate
        }
    }
    
    /**
     Limit to the amount of fetched objects.
     After changing the value, the data must be fetched again, execute `refresh()` method.
    */
    open var fetchLimit: NSInteger? {
        didSet {
            if let fetchLimit = fetchLimit {
                self.fetchedResultsController.fetchRequest.fetchLimit = fetchLimit
            }
        }
    }
    
    /**
     Result sorting.
     After changing the value, the data must be fetched again, execute `refresh()` method.
     */
    open var sortDescriptors: [NSSortDescriptor] {
        didSet {
            self.fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
        }
    }
    
    /**
     A Key Path used for categorization and group data using the given `keypath`.
     This value cannot be changed.
     */
    private(set) open var sectionNameKeyPath: String?
    
    /**
     Name for `Core Data` cache.
     This value cannot be changed.
     */
    private(set) open var cacheName: String?
    
    /**
     The Core Data Managed Object Context.
     */
    open let managedObjectContext: NSManagedObjectContext
    
    /**
     The Entity name.
     */
    dynamic lazy var entityName: String = {
        return Entity.simpleClassName()
    }()
    
    
    // MARK: - Initialization
    
    /**
     Inits the `Core Data Provider`.
     The data will not be fetched after created.
     To fetch data, call `refresh()`.
     
     - parameter sortDescriptors: Data sort.
 
     - parameter context: `Core Data` Managed Object Context.
     */
    public convenience init(sortDescriptors: [NSSortDescriptor],
                            managedObjectContext context: NSManagedObjectContext) {
        
        self.init(sortDescriptors: sortDescriptors,
                  managedObjectContext: context,
                  predicate: nil,
                  fetchLimit: nil,
                  sectionNameKeyPath: nil,
                  cacheName: nil)
    }

    /**
     Inits the `Core Data Provider`.
     The data will not be fetched after created.
     To fetch data, call `refresh()`.
     
     - parameter sortDescriptors: Data sort.
     
     - parameter context: `Core Data` Managed Object Context.
     
     - parameter predicate: `Core Data` predicate used to filter results.
     
     - parameter fetchLimit: Used to limit the amount of returned values.
     
     - parameter sectionNameKeyPath: A Key Path used for categorization
            and group data using the given `keypath`.
     
     - cacheName: Name for `Core Data` cache.
     */
    public init(sortDescriptors: [NSSortDescriptor],
                managedObjectContext context: NSManagedObjectContext,
                predicate: NSPredicate?,
                fetchLimit: NSInteger?,
                sectionNameKeyPath: String?,
                cacheName: String?) {
        
        self.sortDescriptors = sortDescriptors
        self.managedObjectContext = context
        self.predicate = predicate
        self.fetchLimit = fetchLimit
        self.sectionNameKeyPath = sectionNameKeyPath
        self.cacheName = cacheName
        super.init(sectionsAndRows: [[]])
    }
    
    
    // MARK: - Public Methods
    
    /**
     Fetchs data from `Core Data` storage.
     By default, it is not called by default when the `CoreDataProvider` is created.
     
     Also, this method must be called whenever `predicate`, `fetchLimit`, `sectionNameKeyPath` or `cacheName` changes.
     
     Once executed, `objects` will return the fetched objects.
     
     
     ### If you do not want to handle any exception that may happen, you can use: ###
     ````
     try? coreDataProvider.refresh()
     ````
     
     
     ### If you want to handle any exception that may happen, you can use: ###
     ````
     do {
        try coreDataProvider.refresh()
     } catch let error as NSError {
        print("Error: \(error)")
     }
     ````
     */
    open func refresh() throws {
        try self.fetchedResultsController.performFetch()
    }
    
    
    // MARK: - Fetched results controller
    
    /**
     The `NSFetchedResultsController<Entity>` used to back the `CoreDataProvider`.
     */
    open lazy var fetchedResultsController: NSFetchedResultsController<Entity> = {
        let fetchRequest = NSFetchRequest<Entity>()
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.managedObjectContext)
        fetchRequest.entity = entity
        
        fetchRequest.predicate = self.predicate
        
        if let fetchLimit = self.fetchLimit, fetchLimit > 0 {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        fetchRequest.fetchBatchSize = 100
        fetchRequest.sortDescriptors = self.sortDescriptors
        
        let fetchedResultsController = self.instantiateFetchedResultsController(fetchRequest,
                                                                                managedObjectContext: self.managedObjectContext,
                                                                                sectionNameKeyPath: self.sectionNameKeyPath,
                                                                                cacheName: self.cacheName)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    /**
     Instantiates a new `NSFetchedResultsController<Entity>`.
     
     - parameter fetchRequest: NSFetchRequest<Entity> used to request data.
     
     - parameter managedObjectContext: `Core Data` context.
     
     - parameter sectionNameKeyPath: `keypath` for section categorization.
     
     - parameter cacheName: `Core Data` cache name.
     */
    open func instantiateFetchedResultsController(_ fetchRequest: NSFetchRequest<Entity>,
                                                  managedObjectContext: NSManagedObjectContext,
                                                  sectionNameKeyPath: String?,
                                                  cacheName: String?) -> NSFetchedResultsController<Entity> {
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: self.managedObjectContext,
                                          sectionNameKeyPath: self.sectionNameKeyPath,
                                          cacheName: self.cacheName)
    }
    
    
    // MARK: - Data Provider Implementation
    
    /**
     Returns the object of given `ValueType` at given `indexPath`, if exists.
     
     - parameter indexPath: IndexPath to get object.
     
     - returns `ValueType`.
     */
    override public subscript(indexPath: IndexPath) -> Entity? {
        get {
            return self.fetchedResultsController.object(at: indexPath)
        }
    }
    
    /**
     Returns the IndexPath for the given object, if found.

     - parameter value: Object to search.

     - returns: IndexPath.
     */
    override public func indexPath(for value: Entity) -> IndexPath? {
        return self.fetchedResultsController.indexPath(forObject: value)
    }
    
    /**
     Returns the numbers of provided sections.
     
     For one-dimentional arrays, will return 1.
     
     - returns: Int.
     */
    override public func numberOfSections() -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    /**
     Returns the number of objects in the given section.
     
     If given section does not exists, returns 0.
     
     - parameter section: The section to be inquired about how much provided objects it has.
     
     - returns: Int.
     */
    override public func numberOfItems(in section: Int) -> Int {
        guard section < self.numberOfSections() else { return 0 }
        guard let sections = self.fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
}

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

open class CoreDataProvider<Entity: NSManagedObject>: ArrayDataProvider<Entity>, NSFetchedResultsControllerDelegate {
    
    
    // MARK: - Properties
    
    /**
     Objects from this provider.
     */
    override public var objects: [Entity] {
        get {
            return self.fetchedResultsController.fetchedObjects ?? []
        }
    }

    /**
     The predicate to be applyed to every data fetch operation
     */
    open var predicate: NSPredicate? {
        didSet {
            self.fetchedResultsController.fetchRequest.predicate = predicate
        }
    }
    
    /**
    Limit to the amount of fetched objects
    */
    open var fetchLimit: NSInteger? {
        didSet {
            if let fetchLimit = fetchLimit {
                self.fetchedResultsController.fetchRequest.fetchLimit = fetchLimit
            }
        }
    }
    
    /**
     Result sorting
     */
    open var sortDescriptors: [NSSortDescriptor] {
        didSet {
            self.fetchedResultsController.fetchRequest.sortDescriptors = sortDescriptors
        }
    }
    
    /**
     A Key Path for categorization.
     */
    open var sectionNameKeyPath: String?
    
    /**
     Name for Core Data Cache.
     */
    open var cacheName: String?
    
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
    
    public convenience init(sortDescriptors: [NSSortDescriptor],
                            managedObjectContext context: NSManagedObjectContext) {
        
        self.init(sortDescriptors: sortDescriptors,
                  managedObjectContext: context,
                  predicate: nil,
                  fetchLimit: nil,
                  sectionNameKeyPath: nil,
                  cacheName: nil)
    }
    
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
        super.init(with: [])
    }
    
    
    // MARK: - Public Methods
    
    open func refresh() {
        try? self.fetchedResultsController.performFetch()
    }
    
    
    // MARK: - Fetched results controller
    
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
    
    
    open func instantiateFetchedResultsController(_ fetchRequest: NSFetchRequest<Entity>,
                                                  managedObjectContext: NSManagedObjectContext,
                                                  sectionNameKeyPath: String?,
                                                  cacheName: String?) -> NSFetchedResultsController<Entity> {
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: self.managedObjectContext,
                                          sectionNameKeyPath: self.sectionNameKeyPath,
                                          cacheName: self.cacheName)
    }
    
}

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
import Quick
import Nimble
@testable import Glasgow

class CoreDataProviderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Core Data Provider") {
            let modelFileName = "GlasgowTests"
            let databaseFileName = "GlasgowTestsDB"
            let bundle = Bundle(for: type(of: self))
            let stack = CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: bundle)
            var provider: CoreDataProvider<TestEntity>?
            
            beforeEach {
                if let context = stack.managedObjectContext {
                    TestEntity.removeAll(inManagedObjectContext: context)
                }
            }
            
            context("Initialization") {
                
                it("must create object") {
                    // Given
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [],
                                                                managedObjectContext: context,
                                                                predicate: nil,
                                                                fetchLimit: nil,
                                                                sectionNameKeyPath: nil,
                                                                cacheName: nil)
                    }

                    // Then
                    expect(provider).toNot(beNil())
                }
                
                it("Convenience init must create object") {
                    // Given
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                    }
                    
                    // Then
                    expect(provider).toNot(beNil())
                }
            }
            
            it("Method entityName must return correct Entity Name") {
                // Given
                if let context = stack.managedObjectContext {
                    provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                }
                
                // When
                expect(provider).toNot(beNil())
                let entityName = provider?.entityName
                
                // Then
                expect(entityName).to(equal("TestEntity"))
            }
            
            context("Refresh method") {

                var objects: [TestEntity]?
                
                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 2", inManagedObjectContext: context)
                        try? stack.saveContext()
                    }
                }
                
                it("refresh must load objects") {
                    // Given
                    objects = provider?.objects
                    expect(objects).toNot(beNil())
                    expect(objects?.count).to(equal(0))
                    
                    // When
                    provider?.refresh()
                    
                    // Then
                    objects = provider?.objects
                    expect(objects?.count).to(equal(2))
                }
                
            }

            context("fetchLimit must limit amount of returned objects") {
                
                var objects: [TestEntity]?
                
                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 2", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 3", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 4", inManagedObjectContext: context)
                        try? stack.saveContext()
                    }
                }
                
                it("Refresh must apply fetchLimit value") {
                    // Given
                    objects = provider?.objects
                    expect(objects).toNot(beNil())
                    
                    // When
                    provider?.fetchLimit = 3
                    provider?.refresh()
                    
                    // Then
                    objects = provider?.objects
                    expect(objects?.count).to(equal(3))
                }
                
            }
            
            context("predicate must limit amount of returned objects") {
                
                var objects: [TestEntity]?
                
                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 2", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 3", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 4", inManagedObjectContext: context)
                        try? stack.saveContext()
                    }
                }
                
                it("Refresh must apply new predicate") {
                    // Given
                    objects = provider?.objects
                    expect(objects).toNot(beNil())
                    
                    // When
                    provider?.predicate = NSPredicate(format: "name == %@", "test value 4")
                    provider?.refresh()
                    
                    // Then
                    objects = provider?.objects
                    expect(objects?.count).to(equal(1))
                }
                
            }
            
            context("sortDescriptors must change order") {
                
                var objects: [TestEntity]?
                
                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 2", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 3", inManagedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 4", inManagedObjectContext: context)
                        try? stack.saveContext()
                    }
                }
                
                it("Refresh must apply new predicate") {
                    // Given
                    objects = provider?.objects
                    expect(objects).toNot(beNil())
                    
                    // When
                    provider?.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
                    provider?.refresh()
                    
                    // Then
                    objects = provider?.objects
                    expect(objects?.count).to(equal(4))
                    expect(objects?[0].name).to(equal("test value 4"))
                    expect(objects?[1].name).to(equal("test value 3"))
                    expect(objects?[2].name).to(equal("test value 2"))
                    expect(objects?[3].name).to(equal("test value 1"))
                }
                
            }
            
            
            
            
            
            
            
            
            
        }
        
    }
    
}

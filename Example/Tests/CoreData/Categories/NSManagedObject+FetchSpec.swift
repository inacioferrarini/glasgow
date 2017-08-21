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

class NSManagedObjectFetchSpec: QuickSpec {

    override func spec() {

        describe("NSManagedObject Fetch Extensions") {
            let modelFileName = "GlasgowTests"
            let databaseFileName = "GlasgowTestsDB"
            let bundle = Bundle(for: type(of: self))
            let stack = CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: bundle)
            let managedContext = stack.managedObjectContext

            beforeEach {
                if let context = managedContext {
                    TestEntity.removeAll(in: context)
                    _ = TestEntity.testEntity(with: "test value 1", group: "group", in: context)
                    _ = TestEntity.testEntity(with: "test value 2", group: "group", in: context)
                    try? stack.saveContext()
                }
            }

            context("lastObjectFromRequest method") {

                it("must return one object, if exists") {
                    guard let context = managedContext else {
                        fail("context is nil")
                        return
                    }
                    let request: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: TestEntity.simpleClassName())
                    let entity = TestEntity.lastObject(from: request, in: context)
                    expect(entity).toNot(beNil())
                }

                it("must return nil if an error happens") {
                    guard let context = managedContext else {
                        fail("context is nil")
                        return
                    }
                    let request: NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: TestEntity.simpleClassName())
                    request.predicate = NSPredicate(format: "name = %@", "non-existing test value")
                    let entity = TestEntity.lastObject(from: request, in: context)
                    expect(entity).to(beNil())
                }

            }

            context("allObjectsFromRequest method") {

                it("must return fetched objects") {
                    guard let context = managedContext else {
                        fail("context is nil")
                        return
                    }
                    let request: NSFetchRequest = NSFetchRequest<NSManagedObject>(
						entityName: TestEntity.simpleClassName())
                    let entities = TestEntity.allObjects(from: request, in: context)
                    expect(entities.count).to(equal(2))
                }

            }

        }

    }

}

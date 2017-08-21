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

	// swiftlint:disable function_body_length
	// swiftlint:disable cyclomatic_complexity

    override func spec() {

        describe("Core Data Provider") {
            let modelFileName = "GlasgowTests"
            let databaseFileName = "GlasgowTestsDB"
            let bundle = Bundle(for: type(of: self))
            let stack = CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: bundle)
            var provider: CoreDataProvider<TestEntity>?

            beforeEach {
                if let context = stack.managedObjectContext {
                    TestEntity.removeAll(in: context)
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

                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 2", group: "group", in: context)
                        try? stack.saveContext()
                    }
                }

                it("refresh must load objects") {
                    // Given
                    expect(provider?.numberOfSections()).to(equal(0))
                    expect(provider?.numberOfItems(in: 0)).to(equal(0))

                    // When
                    try? provider?.refresh()

                    // Then
                    expect(provider?.numberOfSections()).to(equal(1))
                    expect(provider?.numberOfItems(in: 0)).to(equal(2))
                }

            }

            context("indexPath method") {

                var testEntity: TestEntity?

                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        testEntity = TestEntity.testEntity(with: "test value 1", group: "group", in: context)

                        try? stack.saveContext()
                        try? provider?.refresh()
                    }
                }

                it("Must return indexPath for object") {
                    guard let testEntity = testEntity else {
                        fail("testEntity is nil")
                        return
                    }
                    let indexPath = provider?.path(for: testEntity)
                    expect(indexPath?.section).to(equal(0))
                    expect(indexPath?.row).to(equal(0))
                }

            }

            context("fetchLimit must limit amount of returned objects") {

                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 2", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 3", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 4", group: "group", in: context)
                        try? stack.saveContext()
                    }
                }

                it("Refresh must apply fetchLimit value") {
                    // When
                    provider?.fetchLimit = 3
                    try? provider?.refresh()

                    // Then
                    expect(provider?.numberOfSections()).to(equal(1))
                    expect(provider?.numberOfItems(in: 0)).to(equal(3))
                }

            }

            context("predicate must limit amount of returned objects") {

                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 2", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 3", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 4", group: "group", in: context)
                        try? stack.saveContext()
                    }
                }

                it("Refresh must apply new predicate") {
                    // When
                    provider?.predicate = NSPredicate(format: "name == %@", "test value 4")
                    try? provider?.refresh()

                    // Then
                    expect(provider?.numberOfSections()).to(equal(1))
                    expect(provider?.numberOfItems(in: 0)).to(equal(1))
                }

            }

            context("sortDescriptors must change order") {

                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 2", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 3", group: "group", in: context)
                        _ = TestEntity.testEntity(with: "test value 4", group: "group", in: context)
                        try? stack.saveContext()
                    }
                }

                it("Refresh must apply new predicate") {
                    // When
                    provider?.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
                    try? provider?.refresh()

                    // Then
                    expect(provider?.numberOfSections()).to(equal(1))
                    expect(provider?.numberOfItems(in: 0)).to(equal(4))
                    expect(provider?[IndexPath(row: 0, section: 0)]?.name).to(equal("test value 4"))
                    expect(provider?[IndexPath(row: 1, section: 0)]?.name).to(equal("test value 3"))
                    expect(provider?[IndexPath(row: 2, section: 0)]?.name).to(equal("test value 2"))
                    expect(provider?[IndexPath(row: 3, section: 0)]?.name).to(equal("test value 1"))
                }

            }

            context("method numberOfItems") {

                beforeEach {
                    if let context = stack.managedObjectContext {
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: [], managedObjectContext: context)
                        _ = TestEntity.testEntity(with: "test value 1", group: "group", in: context)
                        try? stack.saveContext()
                    }
                }

                it("when section is greater than amount of sections, must return 0") {
                    try? provider?.refresh()
                    expect(provider?.numberOfItems(in: 0)).to(equal(1))
                }

                it("when section is lower than amount of sections, must return the amount of items") {
                    try? provider?.refresh()
                    expect(provider?.numberOfItems(in: 1)).to(equal(0))
                }

            }


            context("Multiple Sections") {

                beforeEach {
                    // Given
                    if let context = stack.managedObjectContext {
                        let sortDescriptor = [
                            NSSortDescriptor(key: "group", ascending: true),
                            NSSortDescriptor(key: "name", ascending: true)
                        ]
                        provider = CoreDataProvider<TestEntity>(sortDescriptors: sortDescriptor,
                                                                managedObjectContext: context,
                                                                predicate: nil,
                                                                fetchLimit: nil,
                                                                sectionNameKeyPath: "group",
                                                                cacheName: nil)
                        if let context = stack.managedObjectContext {
                            _ = TestEntity.testEntity(with: "test value 1", group: "group 1", in: context)
                            _ = TestEntity.testEntity(with: "test value 2", group: "group 1", in: context)
                            _ = TestEntity.testEntity(with: "test value 3", group: "group 1", in: context)
                            _ = TestEntity.testEntity(with: "test value 4", group: "group 2", in: context)
                            _ = TestEntity.testEntity(with: "test value 5", group: "group 2", in: context)
                            _ = TestEntity.testEntity(with: "test value 6", group: "group 3", in: context)
                            _ = TestEntity.testEntity(with: "test value 7", group: "group 4", in: context)
                            _ = TestEntity.testEntity(with: "test value 8", group: "group 4", in: context)
                            _ = TestEntity.testEntity(with: "test value 9", group: "group 1", in: context)
                            _ = TestEntity.testEntity(with: "test value 10", group: "group 3", in: context)

                            try? stack.saveContext()
                            try? provider?.refresh()
                        }
                    }
                }

                it("must have correct number of sections") {
                    expect(provider?.numberOfSections()).to(equal(4))
                }

                it("must have correct number of rows in each section") {
                    expect(provider?.numberOfItems(in: 0)).to(equal(4))
                    expect(provider?.numberOfItems(in: 1)).to(equal(2))
                    expect(provider?.numberOfItems(in: 2)).to(equal(2))
                    expect(provider?.numberOfItems(in: 3)).to(equal(2))
                }

				it("must have correct section titles") {
					expect(provider?.title(section: 0)).to(equal("group 1"))
					expect(provider?.title(section: 1)).to(equal("group 2"))
					expect(provider?.title(section: 2)).to(equal("group 3"))
					expect(provider?.title(section: 3)).to(equal("group 4"))
					expect(provider?.title(section: 4)).to(beNil())
				}

			}

        }

    }

	// swiftlint:enable cyclomatic_complexity
	// swiftlint:enable body_length

}

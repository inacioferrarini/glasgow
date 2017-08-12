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

class CoreDataStackSpec: QuickSpec {
    
    override func spec() {
        
        describe("Core Data Stack") {
            
            let modelFileName = "GlasgowTests"
            let databaseFileName = "GlasgowTestsDB"
            let bundle = Bundle(for: type(of: self))
            var stack: CoreDataStack?
            
            context("Initialization") {
                
                it("must create object") {
                    // When
                    stack = CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: bundle)
                    
                    // Then
                    expect(stack).toNot(beNil())
                }

                it("Convenience init must create object") {
                    // When
                    stack = CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName)
                    
                    // Then
                    expect(stack).toNot(beNil())
                }
                
            }

            context("save method") {

                beforeEach {
                    // Given
                    stack = CoreDataStack(modelFileName: modelFileName, databaseFileName: databaseFileName, bundle: bundle)
                }
                
                it("must not crash") {
                    // When
                    var exceptionWasThrown = false
                    var doCompleted = false
                    
                    do {
                        if let context = stack?.managedObjectContext {
                            _ = TestEntity.testEntity(with: "test value", group: "group", in: context)
                        }
                        try stack?.saveContext()
                        doCompleted = true
                    } catch {
                        exceptionWasThrown = true
                    }
                    
                    // Then
                    expect(doCompleted).to(beTruthy())
                    expect(exceptionWasThrown).to(beFalsy())
                }
                
                it("when exception happens, must throws exception") {
                    // When
                    var exceptionWasThrown = false
                    var doCompleted = false
                    
                    do {
                        if let context = stack?.managedObjectContext {
                            _ = TestEntity.testEntity(with: nil, group: "group", in: context)
                        }
                        try stack?.saveContext()
                        doCompleted = true
                    } catch {
                        exceptionWasThrown = true
                    }
                    
                    // Then
                    expect(doCompleted).to(beFalsy())
                    expect(exceptionWasThrown).to(beTruthy())
                }
                
            }
            
        }
        
    }
    
}

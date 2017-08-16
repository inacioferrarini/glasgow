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
import Quick
import Nimble
import OHHTTPStubs
@testable import Glasgow

class ArrayDataSourceSpec: QuickSpec {
    
    override func spec() {
        
        describe("Array Data Source") {

            var items = [Int]()
            let dataProvider = RefreshableDataProvider<Int>(rows: items)
            var dataSource = ArrayDataSource<Int>(with: dataProvider)
            
            beforeEach {
                // Given
                items = [10, 20, 30]
                let dataProvider = RefreshableDataProvider<Int>(rows: items)
                dataSource = ArrayDataSource<Int>(with: dataProvider)
                dataSource.onRefresh = nil
            }
            
            it("Initialization must have given objects") {
                // Then
                expect(dataSource.dataProvider).toNot(beNil())
            }

            describe("objectAtIndexPath") {
                
                it("must return object at given path") {
                    // When
                    let indexPath = IndexPath(row: 0, section: 0)
                    let value = dataSource.object(at: indexPath)
                    
                    // Then
                    expect(value).to(equal(10))
                }
                
                it("must return object at given path again") {
                    // When
                    let indexPath = IndexPath(row: 2, section: 0)
                    let value = dataSource.object(at: indexPath)
                    
                    // Then
                    expect(value).to(equal(30))
                }
                
            }
            
            describe("refresh method") {
                
                var blockWasCalled = false
                
                beforeEach {
                    // Given
                    blockWasCalled = false
                    dataSource.onRefresh = {
                        blockWasCalled = true
                    }
                }
                
                it("must do nothing") {
                    // When
                    dataSource.refresh()
                    
                    // Then
                    expect(blockWasCalled).to(beTruthy())
                }

            }
            
        }
    
    }

}

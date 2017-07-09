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

import UIKit
import Quick
import Nimble
import OHHTTPStubs
@testable import Glasgow

class TableViewArrayDataSourceSpec: QuickSpec {
    
    override func spec() {
        
        describe("Array Table View Data Source") {
            
            describe("Initialization") {
                
                it("convenience init must set default block ") {
                    // Given
                    let items = [10]
                    let tableView = TestTableView()
                    let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, objects: items)

                    // When
                    let indexPath = IndexPath(row: 0, section: 0)
                    let className = dataSource.reuseIdentifier(indexPath)
                    
                    // Then
                    expect(dataSource.objects).toNot(beNil())
                    expect(dataSource.objects.count).to(equal(1))
                    expect(dataSource.reuseIdentifier).toNot(beNil())
                    expect(className).to(equal("NumberTableViewCell"))
                }
                
                it("regular init must set given values") {
                    // Given
                    let items = [10]
                    let tableView = TestTableView()
                    let reuseIdentifier = { (indexPath: IndexPath) -> String in
                        return ""
                    }
                    let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView,
                                                                                        reuseIdentifier: reuseIdentifier,
                                                                                        objects: items)
                    
                    // When
                    let indexPath = IndexPath(row: 0, section: 0)
                    let className = dataSource.reuseIdentifier(indexPath)
                    
                    // Then
                    expect(dataSource.objects).toNot(beNil())
                    expect(dataSource.objects.count).to(equal(1))
                    expect(dataSource.reuseIdentifier).toNot(beNil())
                    expect(className).to(equal(""))
                }
                
            }
            
        }
        
        describe("refresh") {
            
            it("must refresh tableview") {
                // Given
                var blockWasCalled = false
                let items = [10]
                let tableView = TestTableView()
                tableView.register(NumberTableViewCell.self, forCellReuseIdentifier: "NumberTableViewCell")
                tableView.onReloadData = { _ in
                    blockWasCalled = true
                }
                let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, objects: items)
                tableView.dataSource = dataSource
                
                // When
                dataSource.refresh()
                
                // Then
                expect(blockWasCalled).to(beTruthy())
            }
            
        }
        
        it("numberOfRowsInSection must return 3") {
            // Given
            let items = [10, 20, 30]
            let tableView = TestTableView()
            let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, objects: items)

            // When
            let rows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
            
            // Then
            expect(rows).to(equal(3))
        }
        
        describe("cellForRowAt") {
            
            it("must setup cell and return it") {
                // Given
                var blockWasCalled = false
                let items = [10]
                let tableView = TestTableView()
                tableView.register(NumberTableViewCell.self, forCellReuseIdentifier: "NumberTableViewCell")
                let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(
                    for: tableView,
                    objects: items)
                tableView.dataSource = dataSource
                
                let indexPath = IndexPath(row: 0, section: 0)
                
                
                let numberCell = NumberTableViewCell()
                numberCell.setup = { (value) -> Void in
                    blockWasCalled = true
                }
                tableView.onDequeueReusableCell = { (reuseIdentifier, indexPath) -> UITableViewCell in
                     return numberCell
                }

                // When
                let cell = dataSource.tableView(tableView, cellForRowAt: indexPath)
                
                // Then
                expect(cell).toNot(beNil())
                expect(blockWasCalled).to(beTruthy())
            }
            
        }
        
    }
    
}


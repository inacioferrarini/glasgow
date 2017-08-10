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
                    let dataProvider = ArrayDataProvider<Int>(with: items)
                    let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, with: dataProvider)

                    // When
                    let indexPath = IndexPath(row: 0, section: 0)
                    let className = dataSource.reuseIdentifier(indexPath)
                    
                    // Then
                    expect(dataSource.dataProvider).toNot(beNil())
//                    expect(dataSource.dataProvider.count).to(equal(1))
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
                    let dataProvider = ArrayDataProvider<Int>(with: items)
                    let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView,
                                                                                        reuseIdentifier: reuseIdentifier,
                                                                                        with: dataProvider)
                    
                    // When
                    let indexPath = IndexPath(row: 0, section: 0)
                    let className = dataSource.reuseIdentifier(indexPath)
                    
                    // Then
                    expect(dataSource.dataProvider).toNot(beNil())
                    expect(dataSource.dataProvider.numberOfSections()).to(equal(1))
                    expect(dataSource.dataProvider.numberOfItems(in: 0)).to(equal(1))
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
                let dataProvider = ArrayDataProvider<Int>(with: items)
                let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, with: dataProvider)
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
            let dataProvider = ArrayDataProvider<Int>(with: items)
            let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, with: dataProvider)

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
                let dataProvider = ArrayDataProvider<Int>(with: items)
                let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(
                    for: tableView,
                    with: dataProvider)
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


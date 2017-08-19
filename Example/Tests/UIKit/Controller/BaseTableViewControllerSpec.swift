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
@testable import Glasgow

class BaseTableViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var baseTableViewViewController: TestBaseTableViewController?
        var tableView: UITableView?
        var onSetupTableViewBlockWasCalled: Bool?
        var onCreateDataSourceBlockWasCalled: Bool?
        var onCreateDelegateBlockWasCalled: Bool?
        var onCreateRefreshControlBlockWasCalled: Bool?
        
        describe("Initialiation with external datasource and delegate") {

            beforeEach {
                // Given
                baseTableViewViewController = TestBaseTableViewController()
                tableView = UITableView(frame: .zero, style: .plain)
                baseTableViewViewController?.tableView = tableView
                
                onCreateDataSourceBlockWasCalled = false
                onCreateDelegateBlockWasCalled = false
                onCreateRefreshControlBlockWasCalled = false
                
                baseTableViewViewController?.onSetupTableView = nil
                baseTableViewViewController?.onCreateDataSource = nil
                baseTableViewViewController?.onCreateDelegate = nil
                baseTableViewViewController?.onCreateRefreshControl = nil
            }
            
            it("viewDidLoad must call setupTableView") {
                // Given
                baseTableViewViewController?.onSetupTableView = { _ in
                    onSetupTableViewBlockWasCalled = true
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onSetupTableViewBlockWasCalled).to(beTruthy())
            }
            
            it("viewDidLoad must create datasource") {
                // Given
                baseTableViewViewController?.onCreateDataSource = { _ in
                    onCreateDataSourceBlockWasCalled = true
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onCreateDataSourceBlockWasCalled).to(beTruthy())
            }
            
            it("viewDidLoad must create delegate") {
                // Given
                baseTableViewViewController?.onCreateDelegate = { _ in
                    onCreateDelegateBlockWasCalled = true
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onCreateDelegateBlockWasCalled).to(beTruthy())
            }
            
            it("viewDidLoad must create refreshControl") {
                // Given
                baseTableViewViewController?.onCreateRefreshControl = { _ in
                    onCreateRefreshControlBlockWasCalled = true
                }
                baseTableViewViewController?.createRefreshControlMethod = { _ in
                    return UIRefreshControl()
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onCreateRefreshControlBlockWasCalled).to(beTruthy())
            }
            
        }
        
        
        
        describe("Initialiation with internal datasource and delegate") {
            
            beforeEach {
                // Given
                baseTableViewViewController = TestBaseTableViewControllerWithDelegates()
                tableView = UITableView(frame: .zero, style: .plain)
                baseTableViewViewController?.tableView = tableView
                
                onCreateDataSourceBlockWasCalled = false
                onCreateDelegateBlockWasCalled = false
                onCreateRefreshControlBlockWasCalled = false
                
                baseTableViewViewController?.onSetupTableView = nil
                baseTableViewViewController?.onCreateDataSource = nil
                baseTableViewViewController?.onCreateDelegate = nil
                baseTableViewViewController?.onCreateRefreshControl = nil
            }
            
            it("viewDidLoad must call setupTableView") {
                // Given
                baseTableViewViewController?.onSetupTableView = { _ in
                    onSetupTableViewBlockWasCalled = true
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onSetupTableViewBlockWasCalled).to(beTruthy())
            }
            
            it("viewDidLoad must create datasource") {
                // Given
                baseTableViewViewController?.onCreateDataSource = { _ in
                    onCreateDataSourceBlockWasCalled = true
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onCreateDataSourceBlockWasCalled).to(beFalsy())
            }
            
            it("viewDidLoad must create delegate") {
                // Given
                baseTableViewViewController?.onCreateDelegate = { _ in
                    onCreateDelegateBlockWasCalled = true
                }
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onCreateDelegateBlockWasCalled).to(beFalsy())
            }
            
            it("viewDidLoad must create refreshControl") {
                // Given
                baseTableViewViewController?.onCreateRefreshControl = { _ in
                    onCreateRefreshControlBlockWasCalled = true
                }
                baseTableViewViewController?.createRefreshControlMethod = { _ in
                    return UIRefreshControl()
                }
                baseTableViewViewController?.viewDidLoad()
                
                // When
                baseTableViewViewController?.viewDidLoad()
                
                // Then
                expect(onCreateRefreshControlBlockWasCalled).to(beTruthy())
            }
            
        }

        describe("viewWillDisappear") {
            
            var deselectRowBlockWasCalled: Bool?
            
            beforeEach {
                // Given
                baseTableViewViewController = TestBaseTableViewController()
                let tableViewTest = TestTableView()
                tableViewTest.register(NumberTableViewCell.self, forCellReuseIdentifier: "NumberTableViewCell")
                let dataProvider = ArrayDataProvider<Int>(section: [10])
                let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(
                    for: tableViewTest,
                    with: dataProvider)
                tableViewTest.dataSource = dataSource
                
                tableViewTest.deselectRowBlock = { _ in
                    deselectRowBlockWasCalled = true
                }
                deselectRowBlockWasCalled = false
                baseTableViewViewController?.tableView = tableViewTest
                baseTableViewViewController?.viewDidLoad()
                tableView = tableViewTest
            }
            
            it("must deselect selected current index path") {
                // Given
                let indexPath = IndexPath(row: 0, section: 0)
                
                // When
                tableView?.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                baseTableViewViewController?.viewWillDisappear(false)
                
                // Then
                expect(deselectRowBlockWasCalled).to(beTruthy())
            }
            
        }
        
        describe("Data Synchronization") {
            
            beforeEach {
                // Given
                baseTableViewViewController = TestBaseTableViewController()
                tableView = UITableView(frame: .zero, style: .plain)
                baseTableViewViewController?.tableView = tableView
            }
            
            it("didSyncData must stop spinner") {
                // Given
                baseTableViewViewController?.createRefreshControlMethod = { _ in
                    return UIRefreshControl()
                }
                baseTableViewViewController?.viewDidLoad()
                baseTableViewViewController?.refreshControl?.beginRefreshing()
                
                // When
                baseTableViewViewController?.didSyncData()
                
                // Then
                expect(baseTableViewViewController?.refreshControl?.isRefreshing).to(beFalsy())
            }
            
        }
        
    }
    
}

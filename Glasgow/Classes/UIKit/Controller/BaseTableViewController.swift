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

/**
 Provides a basic TableViewController capable of perform data synchronization operations.
 */
open class BaseTableViewController: DataBasedViewController {
    
    
    // MARK: - Properties
    
    /**
     Refresh control used to provide user feedback.
     Can be created by overriding `createRefreshControl()`.
     */
    open var refreshControl: UIRefreshControl?
    /**
     Reference to the table view itself.
     */
    @IBOutlet open weak var tableView: UITableView?

    /**
     TableView's DataSource.
     Can be created by overriding `createDataSource()`.
     */
    open var dataSource: UITableViewDataSource?
    /**
     TableView's DataSource.
     Can be created by overriding `createDelegate()`.
     */
    open var delegate: UITableViewDelegate?
    
    
    // MARK: - Initialization
    
    /**
     Called when view is loaded.
     If tableView is defined, setups it by calling `setupTableView()`.
     
     If this class implements UITableViewDataSource, sets ifself as datasource.
     Else, calls `createDataSource()` and sets the returned data source as tableview's data source.

     If this class implements UITableViewDelegate, sets ifself as delegate.
     Else, calls `createDelegate()` and sets the returned data source as tableview's delegate.
     
     Finally, if `createRefreshControl()` returns an object, sets it as tableview's refresh control.
     */
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = self.tableView {
            self.setupTableView()
            
            if let selfAsDataSource = self as? UITableViewDataSource {
                tableView.dataSource = selfAsDataSource
            } else {
                self.dataSource = self.createDataSource()
                tableView.dataSource = self.dataSource
            }
            
            if let selfAsDelegate = self as? UITableViewDelegate {
                tableView.delegate = selfAsDelegate
            } else {
                self.delegate = self.createDelegate()
                tableView.delegate = self.delegate
            }
            
            if let refreshControl = self.createRefreshControl() {
                self.refreshControl = refreshControl
                refreshControl.addTarget(self, action: #selector(self.performDataSync), for: .valueChanged)
                tableView.addSubview(refreshControl)
                tableView.reloadData()
            }
        }
    }
    
    /**
     Called when view is will become not visible.
     Deselect's selected tableview's row.
     */
    override open func viewWillDisappear(_ animated: Bool) {
        if let tableView = self.tableView,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Data Syncrhonization
    
    /**
     Data synchronization was completed.
     
     If a refresh control is being used, ends its refreshing.
     */
    override open func didSyncData() {
        if let refreshControl = self.refreshControl {
            refreshControl.endRefreshing()
        }
        super.didSyncData()
    }
    
    
    // MARK: - Child classes are expected to override these methods
    
    /**
     Setups the TableView (manually register cells, etc).
     By default, does nothing.
     */
    open func setupTableView() {}

    /**
     Create the DataSource to be used by the TableView.
     
     By default, returns `nil`.
     
     - returns the UITableViewDataSource to be used by the tableView.
     */
    open func createDataSource() -> UITableViewDataSource? { return nil }

    /**
     Create the Delegate to be used by the TableView.
     
     By default, returns `nil`.
     
     - returns the UITableViewDelegate to be used by the tableView.
     */
    open func createDelegate() -> UITableViewDelegate? { return nil }
    
    /**
     Creates the refresh control to be used by the TableView.
     
     By default, returns `nil`.
     
     - returns the UIRefreshControl to be used by the tableView.
     */
    open func createRefreshControl() -> UIRefreshControl? { return nil }
    
}

//
//  TestBaseTableViewController.swift
//  Glasgow
//
//  Created by Inacio Ferrarini on 09/07/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
@testable import Glasgow

class TestBaseTableViewController: BaseTableViewController {

    var onSetupTableView: (() -> ())?
    var onCreateDataSource: (() -> ())?
    var onCreateDelegate: (() -> ())?
    var onCreateRefreshControl: (() -> ())?
    var createRefreshControlMethod: (() -> UIRefreshControl)?
    
    override open func setupTableView() {
        self.onSetupTableView?()
        super.setupTableView()
    }
    
    override open func createDataSource() -> UITableViewDataSource? {
        self.onCreateDataSource?()
        return super.createDataSource()
    }

    override open func createDelegate() -> UITableViewDelegate? {
        self.onCreateDelegate?()
        return super.createDelegate()
    }
    
    override open func createRefreshControl() -> UIRefreshControl? {
        self.onCreateRefreshControl?()
        _ = super.createRefreshControl()
        return createRefreshControlMethod?() ?? nil
    }
    
}

//
//  TestBaseTableViewController.swift
//  Glasgow
//
//  Created by Inacio Ferrarini on 09/07/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
@testable import Glasgow

class TestBaseTableViewControllerWithDelegates: TestBaseTableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - UITableViewDataSource delegate
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

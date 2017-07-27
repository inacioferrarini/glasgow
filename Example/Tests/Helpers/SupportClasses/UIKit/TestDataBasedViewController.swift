//
//  TestDataBasedViewController.swift
//  Glasgow
//
//  Created by Inacio Ferrarini on 09/07/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
@testable import Glasgow

class TestDataBasedViewController: DataBasedViewController {

    var onPerformDataSync: (() -> ())?
    var onShouldSyncData: (() -> Bool)?
    var onWillSyncData: (() -> ())?
    var onSyncData: (() -> ())?
    var onDidSyncData: (() -> ())?
    
    override open func performDataSync() {
        self.onPerformDataSync?()
        super.performDataSync()
    }
    
    override open func shouldSyncData() -> Bool {
        _ = super.shouldSyncData()
        return onShouldSyncData?() ?? false
    }
    
    override open func willSyncData() {
        super.willSyncData()
        self.onWillSyncData?()
    }
    
    override open func syncData() {
        super.syncData()
        self.onSyncData?()
    }
    
    override open func didSyncData() {
        super.didSyncData()
        self.onDidSyncData?()
    }
    
}

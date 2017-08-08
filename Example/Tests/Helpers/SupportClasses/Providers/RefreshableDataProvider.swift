//
//  RefreshableDataProvider.swift
//  Glasgow
//
//  Created by José Inácio Athayde Ferrarini on 07/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
@testable import Glasgow

class RefreshableDataProvider<Type: Equatable>: ArrayDataProvider<Type>, Refreshable {

    open var onRefresh: (() -> ())?
    
    func refresh() {
        self.onRefresh?()
    }
    
}

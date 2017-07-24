//
//  NumberTableViewCell.swift
//  NetworkingArrow
//
//  Created by Inacio Ferrarini on 03/07/17.
//  Copyright © 2017 br.com.inacio. All rights reserved.
//

import UIKit
@testable import Glasgow

class NumberTableViewCell: ConfigurableTableViewCell<Int> {

    var setup: ((Int) -> Void)?
    
    override func setup(with value: Int) {
        super.setup(with: value)
        if let setup = self.setup {
            setup(value)
        }
    }

}

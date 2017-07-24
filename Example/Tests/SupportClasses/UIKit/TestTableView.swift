//
//  TestTableView.swift
//  NetworkingArrow
//
//  Created by Inacio Ferrarini on 04/07/17.
//  Copyright © 2017 br.com.inacio. All rights reserved.
//

import UIKit

class TestTableView: UITableView {

    var onDequeueReusableCell: ((String, IndexPath) -> UITableViewCell)?
    var onReloadData: (() -> ())?
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        if let onDequeueReusableCell = self.onDequeueReusableCell {
            return onDequeueReusableCell(identifier, indexPath)
        }
        return UITableViewCell()
    }
    
    override func reloadData() {
        if let onReloadData = self.onReloadData {
            onReloadData()
        }
    }
    
}

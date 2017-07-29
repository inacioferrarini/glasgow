//
//  TableViewDelegate.swift
//  Pods
//
//  Created by Inacio Ferrarini on 23/07/17.
//
//

import UIKit

/**
 Basic UITableViewDelegate abstracting value selection, having elements of type `Type` and using `ConfigurableTableViewCell`
 */
open class TableViewBlockDelegate<CellType: UITableViewCell, Type: Equatable>: NSObject, UITableViewDelegate
    where CellType: Configurable {
    
    
    // MARK: - Properties
    
    /**
     DataSource providing objects.
     */
    let dataSource: TableViewArrayDataSource<CellType, Type>
    
    /**
     When a row is selected, its related model will be supplied.
     */
    let onSelected: ((Type) -> ())
    
    
    // MARK: - Initialization
    
    /**
     Inits the Delegate.
     
     - parameter dataSource: DataSource backing the TableView, where data will be extracted from.
     
     - parameter onSelected: Logic to handle value selection.
     */
    public init(with dataSource: TableViewArrayDataSource<CellType, Type>,
                         onSelected: @escaping ((Type) -> ())) {
        self.dataSource = dataSource
        self.onSelected = onSelected
        super.init()
    }
    
    
    // MARK: - Row Selection
    
    /**
     TableView selection method.
     
     - parameter tableView: Where the value was selected.
     
     - parameter indexPath: The selected row to be related to the selected value.
     */
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRowObject = self.dataSource.object(at: indexPath) else { return }
        self.onSelected(selectedRowObject)
    }
    
}

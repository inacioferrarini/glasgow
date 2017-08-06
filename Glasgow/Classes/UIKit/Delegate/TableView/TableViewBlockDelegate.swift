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

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
 Array-based generic data source having elements of type `Type`.
 */
open class ArrayDataSource<Type: Equatable>: NSObject {


    // MARK: - Properties

    /**
     `DataProvider` for this object.
     As ArrayDataSource is array-based, the data provider is array-based as well.
     */
    open var dataProvider: ArrayDataProvider<Type>
    
    /**
     Block to be called whenever `refresh()` method is called.
     */
    open var onRefresh: (() -> ())?

    
    // MARK: - Initialization

    /**
     Inits with given `DataProvider`.
     
     - parameter dataProvider: The array-based Data provider.
     */
    public init(with dataProvider: ArrayDataProvider<Type>) {
        self.dataProvider = dataProvider
    }


    // MARK: - Public Methods

    /**
     Propagates through `onRefresh` a refresh for interested objects.
     */
    open func refresh() {
        if let dataProvider = self.dataProvider as? Refreshable {
            try? dataProvider.refresh()
        }
        self.onRefresh?()
    }

    /**
     Returns the object at the given `indexPath` row, if exists.
     
     - parameter at: The index path.
     
     - returns: The object of type `Type` at given `indexPath` row, or `nil` if not found.
     */
    open func object(at indexPath: IndexPath) -> Type? {
        return dataProvider[indexPath]
    }

}

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
 Basic UITableViewDelegate abstracting paging.
 When the TableView is scrolled to the bottom, will check if should fetch the next page.
 */
open class PageLoaderTableViewDelegate<CellType: UITableViewCell, Type: Equatable>: TableViewBlockDelegate<CellType, Type>
    where CellType: Configurable {
    
    
    // MARK: - Properties
    
    /**
     Returns if the `loadNextPage` should be called.
     */
    let shouldLoadNextPage: (() -> Bool)
    
    /**
     Loads the next page
     */
    let loadNextPage: (() -> ())
    
    
    // MARK: - Initialization
    
    /**
     Inits the Delegate.
     
     - parameter with: DataSource backing the TableView, where data will be extracted from.
     
     - parameter onSelected: Logic to handle value selection.
     
     - parameter shouldLoadNextPage: Validation logic for page loading.
     
     - parameter loadNextPage: Logic to load next page.
     */
    public required init(with dataSource: TableViewArrayDataSource<CellType, Type>,
                         onSelected: @escaping ((Type) -> ()),
                         shouldLoadNextPage: @escaping (() -> Bool),
                         loadNextPage: @escaping (() -> ())) {
        self.shouldLoadNextPage = shouldLoadNextPage
        self.loadNextPage = loadNextPage
        super.init(with: dataSource,
                   onSelected: onSelected)
    }
    
    
    // MARK: - Pagination
    
    /**
     UIScrollView Delegate method. Called when the scrolling ends.
     
     - parameter scrollView: Where the scrolling slowed.
     */
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.shouldLoadNextPage() {
            let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
            if endScrolling >= scrollView.contentSize.height {
                DispatchQueue.main.async { [weak self] in
                    self?.loadNextPage()
                }
            }
        }
    }
    
}

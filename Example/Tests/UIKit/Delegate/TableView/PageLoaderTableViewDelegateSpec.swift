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
import Quick
import Nimble
import OHHTTPStubs
@testable import Glasgow

class PageLoaderTableViewDelegateSpec: QuickSpec {
    
    override func spec() {
        
        describe("Page Loader Table View Delegate") {
            // Given
            let items = [10]
            let tableView = TestTableView()
            let dataProvider = ArrayDataProvider<Int>(with: items)
            let dataSource = TableViewArrayDataSource<NumberTableViewCell, Int>(for: tableView, with: dataProvider)
            var delegate: PageLoaderTableViewDelegate<NumberTableViewCell, Int>?
            
            it("Initialization must create object") {
                // When
                let onSelected: ((Int) -> Void) = { _ in
                }
                let shouldLoadNextPage: (() -> Bool) = { _ in
                    return true
                }
                let loadNextPage: (() -> ()) = { _ in
                }
                
                delegate = PageLoaderTableViewDelegate<NumberTableViewCell, Int>(with: dataSource,
                                                                                 onSelected: onSelected,
                                                                                 shouldLoadNextPage: shouldLoadNextPage,
                                                                                 loadNextPage: loadNextPage)
                
                // Then
                expect(delegate).toNot(beNil())
            }
            
            it("scrollViewDidEndDecelerating must call block") {
                // Given
                var blockWasCalled = false
                
                // When
                let onSelected: ((Int) -> Void) = { _ in
                }
                let shouldLoadNextPage: (() -> Bool) = { _ in
                    return true
                }
                let loadNextPage: (() -> ()) = { _ in
                    blockWasCalled = true
                }
                
                delegate = PageLoaderTableViewDelegate<NumberTableViewCell, Int>(with: dataSource,
                                                                                 onSelected: onSelected,
                                                                                 shouldLoadNextPage: shouldLoadNextPage,
                                                                                 loadNextPage: loadNextPage)
                
                // Then
                expect(delegate).toNot(beNil())
                
                let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
                scrollView.contentOffset.y = 350
                
                delegate?.scrollViewDidEndDecelerating(scrollView)
                
                expect(blockWasCalled).toEventually(beTruthy())
            }
            
        }
        
    }
    
}

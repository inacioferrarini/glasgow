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
@testable import Glasgow

class TestBaseTableViewController: BaseTableViewController {

    var onSetupTableView: (() -> Void)?
    var onCreateDataSource: (() -> Void)?
	// swiftlint:disable weak_delegate
    var onCreateDelegate: (() -> Void)?
	// swiftlint:enable weak_delegate

    var onCreateRefreshControl: (() -> Void)?
    var createRefreshControlMethod: (() -> UIRefreshControl)?

    override open func setupTableView() {
        self.onSetupTableView?()
        super.setupTableView()
    }

    override open func createDataSource() -> UITableViewDataSource? {
        self.onCreateDataSource?()
        return super.createDataSource()
    }

    override open func createDelegate() -> UITableViewDelegate? {
        self.onCreateDelegate?()
        return super.createDelegate()
    }

    override open func createRefreshControl() -> UIRefreshControl? {
        self.onCreateRefreshControl?()
        _ = super.createRefreshControl()
        return createRefreshControlMethod?() ?? nil
    }

}

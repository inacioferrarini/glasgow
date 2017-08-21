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

import Foundation
import Quick
import Nimble
@testable import Glasgow

class DataBasedViewControllerSpec: QuickSpec {

	// swiftlint:disable function_body_length

    override func spec() {

        var dataBasedViewController: TestDataBasedViewController?
        var onPerformDataSyncBlockWasCalled: Bool?
        var onWillSyncDataBlockWasCalled: Bool?
        var onSyncDataBlockWasCalled: Bool?
        var onDidSyncDataBlockWasCalled: Bool?
        var courtainView: UIView?


        describe("Initialiation") {

            var onPerformDataSyncBlockWasCalled = false

            beforeEach {
                // Given
                dataBasedViewController = TestDataBasedViewController()
                dataBasedViewController?.onPerformDataSync = { _ in
                    onPerformDataSyncBlockWasCalled = true
                }
            }

            it("viewWillAppear must call performDataSync") {
                // When
                dataBasedViewController?.viewWillAppear(false)

                // Then
                expect(onPerformDataSyncBlockWasCalled).to(beTruthy())
            }
        }



        describe("Data Synchronization") {

            beforeEach {
                // Given
                onPerformDataSyncBlockWasCalled = false
                onWillSyncDataBlockWasCalled = false
                onSyncDataBlockWasCalled = false
                onDidSyncDataBlockWasCalled = false

                dataBasedViewController = TestDataBasedViewController()
                dataBasedViewController?.onPerformDataSync = { _ in
                    onPerformDataSyncBlockWasCalled = true
                }
                dataBasedViewController?.onWillSyncData = { _ in
                    onWillSyncDataBlockWasCalled = true
                }
                dataBasedViewController?.onSyncData = { _ in
                    onSyncDataBlockWasCalled = true
                }
                dataBasedViewController?.onDidSyncData = { _ in
                    onDidSyncDataBlockWasCalled = true
                }
            }

            it("performDataSync, when shouldSyncData is true, must call all methods ") {
                // Given
                dataBasedViewController?.onShouldSyncData = { _ in
                    return true
                }

                // When
                dataBasedViewController?.performDataSync()

                // Then
                expect(onPerformDataSyncBlockWasCalled).to(beTruthy())
                expect(onWillSyncDataBlockWasCalled).toEventually(beTruthy())
                expect(onSyncDataBlockWasCalled).to(beTruthy())
                expect(onDidSyncDataBlockWasCalled).to(beTruthy())
            }

            it("performDataSync, when shouldSyncData is false, must call only didSyncData") {
                // Given
                dataBasedViewController?.onShouldSyncData = { _ in
                    return false
                }

                // When
                dataBasedViewController?.performDataSync()

                // Then
                expect(onPerformDataSyncBlockWasCalled).to(beTruthy())
                expect(onWillSyncDataBlockWasCalled).to(beFalsy())
                expect(onSyncDataBlockWasCalled).to(beFalsy())
                expect(onDidSyncDataBlockWasCalled).to(beTruthy())
            }
        }



        describe("Courtain Methods") {
            beforeEach {
                // Given
                courtainView = UIView()
                dataBasedViewController = TestDataBasedViewController()
                dataBasedViewController?.courtainView = courtainView
            }

            it("showCourtainView must show courtain") {
                // Given
                courtainView?.isHidden = true

                // When
                dataBasedViewController?.showCourtainView()

                // Then
                expect(courtainView?.isHidden).toEventually(beFalsy())
            }

            it("hideCourtainView must hide courtain") {
                // Given
                courtainView?.isHidden = false

                // When
                dataBasedViewController?.hideCourtainView()

                // Then
                expect(courtainView?.isHidden).toEventually(beTruthy())
            }
        }

    }

	// swiftlint:enable body_length

}

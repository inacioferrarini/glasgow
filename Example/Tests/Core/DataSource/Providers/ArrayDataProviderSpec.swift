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
import OHHTTPStubs
@testable import Glasgow

class ArrayDataProviderSpec: QuickSpec {

	// swiftlint:disable function_body_length

    override func spec() {

        describe("Array Data Provider") {

			context("Initialization") {

				it("section initializer must have nil title") {
					// Given
					let items = [10, 20, 30]

					// When
					let dataProvider = ArrayDataProvider<Int>(section: items)

					// Then
					expect(dataProvider.numberOfSections()).to(equal(1))
					expect(dataProvider.numberOfItems(in: 0)).to(equal(3))
					expect(dataProvider.title(section: 0)).to(beNil())
				}

				it("sections initializer must have nil title") {
					// Given
					let items = [[10, 20, 30], [40], [100, 60]]

					// When
					let dataProvider = ArrayDataProvider<Int>(sections: items)

					// Then
					expect(dataProvider.numberOfSections()).to(equal(3))

					expect(dataProvider.numberOfItems(in: 0)).to(equal(3))
					expect(dataProvider.numberOfItems(in: 1)).to(equal(1))
					expect(dataProvider.numberOfItems(in: 2)).to(equal(2))

					expect(dataProvider.title(section: 0)).to(beNil())
					expect(dataProvider.title(section: 1)).to(beNil())
					expect(dataProvider.title(section: 2)).to(beNil())
				}

				it("sections and titles initializer must have given titles") {
					// Given
					let items = [[10, 30], [40], [100]]
					let titles = ["Section Title 1", "Section Title 2", "Section Title 3"]

					// When
					let dataProvider = ArrayDataProvider<Int>(sections: items, titles: titles)

					// Then
					expect(dataProvider.numberOfSections()).to(equal(3))

					expect(dataProvider.numberOfItems(in: 0)).to(equal(2))
					expect(dataProvider.numberOfItems(in: 1)).to(equal(1))
					expect(dataProvider.numberOfItems(in: 2)).to(equal(1))

					expect(dataProvider.title(section: 0)).to(equal("Section Title 1"))
					expect(dataProvider.title(section: 1)).to(equal("Section Title 2"))
					expect(dataProvider.title(section: 2)).to(equal("Section Title 3"))
				}

			}

			context("Using Rows") {

				var items = [Int]()
				var dataProvider = ArrayDataProvider<Int>(section: [])

				beforeEach {
					// Given
					items = [10, 20, 30]
					dataProvider = ArrayDataProvider<Int>(section: items)
				}

				it("Initialization must have given objects") {
					// Then
					expect(dataProvider.numberOfSections()).to(equal(1))
					expect(dataProvider.numberOfItems(in: 0)).to(equal(3))
				}

				it("index must return the correct index") {
					// Then
					expect(dataProvider.path(for: 20)?.row).to(equal(1))
				}

				it("subscript must return the correct object for given index") {
					// Then
					let indexPath = IndexPath(row: 0, section: 0)
					expect(dataProvider[indexPath]).to(equal(10))
				}

				it("update must update the given values") {
					// When
					dataProvider.elements = [[10, 20]]

					// Then
					expect(dataProvider.numberOfSections()).to(equal(1))
					expect(dataProvider.numberOfItems(in: 0)).to(equal(2))
				}

			}


			context("Using Sections and Rows") {

				var sectionsAndRows = [[Int]]()
				var dataProvider = ArrayDataProvider<Int>(sections: [[]])

				beforeEach {
					// Given
					sectionsAndRows = [[10, 20, 30], [40], [100, 60]]
					dataProvider = ArrayDataProvider<Int>(sections: sectionsAndRows)
				}

				it("Initialization must have given objects") {
					// Then
					expect(dataProvider.numberOfSections()).to(equal(3))
					expect(dataProvider.numberOfItems(in: 0)).to(equal(3))
					expect(dataProvider.numberOfItems(in: 1)).to(equal(1))
					expect(dataProvider.numberOfItems(in: 2)).to(equal(2))
				}

				it("index must return the correct index") {
					// Then
					expect(dataProvider.path(for: 60)?.section).to(equal(2))
					expect(dataProvider.path(for: 60)?.row).to(equal(1))
				}

				it("subscript must return the correct object for given index") {
					// Then
					let indexPath = IndexPath(row: 0, section: 1)
					expect(dataProvider[indexPath]).to(equal(40))
				}

				it("update must update the given values") {
					// When
					dataProvider.elements = [[10, 20, 30]]

					// Then
					expect(dataProvider.numberOfSections()).to(equal(1))
					expect(dataProvider.numberOfItems(in: 0)).to(equal(3))
				}

			}

        }

    }

	// swiftlint:enable body_length

}

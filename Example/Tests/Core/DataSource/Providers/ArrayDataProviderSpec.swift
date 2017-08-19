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
    
    override func spec() {
        
        describe("Array Data Provider") {
			
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
					expect(dataProvider.indexPath(for: 20)?.row).to(equal(1))
				}
				
				it("subscript must return the correct object for given index") {
					// Then
					let indexPath = IndexPath(row: 0, section: 0)
					expect(dataProvider[indexPath]).to(equal(10))
				}
				
				it("update must update the given values") {
					// When
					dataProvider.update(section: [10, 20])
					
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
					expect(dataProvider.indexPath(for: 60)?.section).to(equal(2))
					expect(dataProvider.indexPath(for: 60)?.row).to(equal(1))
				}
				
				it("subscript must return the correct object for given index") {
					// Then
					let indexPath = IndexPath(row: 0, section: 1)
					expect(dataProvider[indexPath]).to(equal(40))
				}
				
				it("update must update the given values") {
					// When
					dataProvider.update(sections: [[10, 20, 30]])
					
					// Then
					expect(dataProvider.numberOfSections()).to(equal(1))
					expect(dataProvider.numberOfItems(in: 0)).to(equal(3))
				}
				
			}
			
        }
		
    }
    
}

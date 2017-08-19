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
 Matrix-based generic data provider having elements of type `ElementType`.

 Begin matrix-based allows this data provider to work both as single-sectioned (array)
 and multi-sectiond (matrix) without changes.

 Methods that receive a single section as parameter, will handle data as an array (rows only),
 while methods that receive multiple sections as parameter will handle data as an matrix, begin
 translatable as sections and rows.
 */
open class ArrayDataProvider<ElementType: Equatable>: NSObject, DataProvider {

    
    // MARK: - Properties
    
    /**
     Stored sections and rows.
     */
    private(set) var elements: [[ElementType]]
    
    
    // MARK: - Initialization
    
    /**
	 Inits with given elements.
     Data will be handled as a single section array.
     
	 - parameter section: The section and its rows to be stored.
     */
    public convenience init(section: [ElementType]) {
        self.init(sections: [section])
    }
	
	/**
	 Inits with given elements.
	
	 - parameter section: The sections and its rows to be stored.
	*/
	public init(sections: [[ElementType]]) {
		self.elements = sections
	}
	
	
    // MARK: - Data Provider Implementation
    
    /**
     Returns the element of given `ValueType` at given `indexPath`, if exists.
     
	 - parameter indexPath: IndexPath to get object. If the given `indexPath.section`
		is greater than the amount of stored sections, or if the given `indexPath.row`
		is greater than the amount of rows for given section, returns nil.
	
	 - returns `ElementType`?.
     */
    public subscript(indexPath: IndexPath) -> ElementType? {
        get {
			let section = indexPath.section
			let row = indexPath.row
			guard section < self.numberOfSections() else { return nil }
			guard row < self.numberOfItems(in: section) else { return nil }
            return self.elements[section][row]
        }
    }
	
	/**
	 Replaces all sections and its rows with the given section and its rows.
	
	 - parameter section: The section and its rows to be stored.
	*/
	public func update(section: [ElementType]) {
		self.update(sections: [section])
	}
	
	/**
	 Replaces all sections and its rows with the given sections and its rows.
	
	 - parameter sections: The section and its rows to be stored.
	*/
	public func update(sections: [[ElementType]]) {
		self.elements = sections
	}

    /**
     Returns the IndexPath for the given element, if found.
     
     - parameter element: Object to search.
     
     - returns: IndexPath.
     */
	public func indexPath(for element: ValueType) -> IndexPath? {
		var indexPath: IndexPath?
		for section in 0..<numberOfSections() {
			guard let row = self.elements[section].index(of: element) else { continue }
			indexPath = IndexPath(row: row, section: section)
			break
		}
		return indexPath
	}
	
    /**
     Returns the numbers of stored sections.
	
     - returns: Int.
     */
    public func numberOfSections() -> Int {
        return self.elements.count
    }
	
    /**
     Returns the number of elements in the given section.
     
	 - remarks: If given section does not exists, returns 0.
	
	 - parameter section: The section to be inquired about how much rows it has.

     - returns: Int.
     */
	public func numberOfItems(in section: Int) -> Int {
		guard section < self.numberOfSections() else { return 0 }
		return self.elements[section].count
	}
	
}

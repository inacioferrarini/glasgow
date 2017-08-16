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
 Array-based generic data provider having elements of type `Type`.
 
 Although arrays are one-dimentional, internally it is stored as a matrix, allowing
 to be used as sections and rows.

 */
open class ArrayDataProvider<Type: Equatable>: NSObject, DataProvider {

    
    // MARK: - Properties
    
    /**
     Objects from this provider.
     */
    private(set) var objects: [[Type]]
    
    
    // MARK: - Initialization
    
    /**
	 Inits with given objects.
     
	 - parameter rows: The objects to be contained.
     */
    public convenience init(rows: [Type]) {
        self.init(sectionsAndRows: [rows])
    }
	
	/**
	 Inits with given objects.
	
	 - parameter sectionsAndRows: The Sections and Rows to be contained.
	*/
	public init(sectionsAndRows: [[Type]]) {
		self.objects = sectionsAndRows
	}
	
	
    // MARK: - Data Provider Implementation
    
    /**
     Returns the object of given `ValueType` at given `indexPath`, if exists.
     
     - parameter indexPath: IndexPath to get object.
     
     - returns `ValueType`.
     */
    public subscript(indexPath: IndexPath) -> Type? {
        get {
			let section = indexPath.section
			guard section < self.numberOfSections() else { return nil }
            return self.objects[section][indexPath.row]
        }
    }
	
	/**
	 Updates the contained objects.
	
	 - parameter rows: The objects to be contained.
	*/
	public func update(rows: [Type]) {
		self.update(sectionsAndRows: [rows])
	}
	
	/**
	 Updates the contained objects.
	
	 - parameter sectionsAndRows: The Sections and Rows to be contained.
	*/
	public func update(sectionsAndRows: [[Type]]) {
		self.objects = sectionsAndRows
	}
	
    /**
     Returns the IndexPath for the given object, if found.
     
     - parameter value: Object to search.
     
     - returns: IndexPath.
     */
	public func indexPath(for value: ValueType) -> IndexPath? {
		
		var indexPath: IndexPath?
		
		for section in 0..<numberOfSections() {
			guard let row = self.objects[section].index(of: value) else { continue }
			indexPath = IndexPath(row: row, section: section)
			break
		}
		
		return indexPath
	}
	
    /**
     Returns the numbers of provided sections.
	
     For one-dimentional arrays, will return 1.
     
     - returns: Int.
     */
    public func numberOfSections() -> Int {
        return self.objects.count
    }
    
    /**
     Returns the number of objects in the given section.
     
     If given section does not exists, returns 0.
     
     - parameter section: The section to be inquired about how much provided objects it has.
     
     - returns: Int.
     */
	public func numberOfItems(in section: Int) -> Int {
		guard section < self.numberOfSections() else { return 0 }
		return self.objects[section].count
	}
	
}

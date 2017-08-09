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

/**
 Provides data for a DataSource. Its provided objects will be of type `ValueType`.
 
 Its elements shall not be accessed directly, granting its usage throught its methods,
 allowing better compatibility com different kinds of data providers.
 */
public protocol DataProvider {
    
    /**
     The type of the provided object.
     */
    associatedtype ValueType
    
    /**
     Returns the object of given `ValueType` at given `indexPath`, if exists.
     */
    subscript(at indexPath: IndexPath) -> ValueType? { get }
    
    /**
     Returns the IndexPath for the given value, if found.
     
     - returns: IndexPath or nil.
     */
    func indexPath(for value: ValueType) -> IndexPath?
    
    
    /**
     Returns the numbers of provided sections.
     
     For one-dimention arrays, will return 1.
     
     - returns: Int
     */
    func numberOfSections() -> Int
    
    /**
     Returns the number of provided itens for the given section.
     
     If requested section does not exists, returns 0.
     
     - parameter section: The section to be inquired about how much provided objects it has.
     */
    func numberOfItems(in section: Int) -> Int
    
}

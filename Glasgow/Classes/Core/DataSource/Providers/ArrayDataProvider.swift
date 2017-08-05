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
 */
open class ArrayDataProvider<Type: Equatable>: NSObject, DataProvider {

    
    // MARK: - Properties
    
    /**
     Objects from this provider.
     */
    private(set) public var objects: [Type]
    
    /**
     Returns the amount of stored objects.
     */
    public var count: Int {
        get {
            return self.objects.count
        }
    }
    
    
    // MARK: - Initialization
    
    /**
     Inits with given objects.
     
     - parameter objects: The objects to be contained.
     */
    public init(with objects: [Type]) {
        self.objects = objects
    }
    
    
    // MARK: - Indexing
    
    public func index(of element: Type) -> Int? {
        return self.objects.index(of: element)
    }

    
    // MARK: - Subscript
    
    subscript(index: Int) -> Type {
        get {
            return self.objects[index]
        }
    }
    
}

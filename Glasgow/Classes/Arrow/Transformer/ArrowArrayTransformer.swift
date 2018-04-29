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
import Arrow

/**
 Uses `Arrow` to transform a given object of type AnyObject? into an array of target type, `Type`.
*/
open class ArrowArrayTransformer<Type: ArrowParsable>: Transformer, KeyPathTransformer {

    /**
     Default Initialization.
    */
    public init() {}

    /**
     Transforms the input type AnyObject? and returns [`Type`] as output.
     
     - parameter input: The object to be transformed.
     
     - returns: `Type`
     */
    public func transform(_ input: IType) -> OType {
        return self.transform(input, keyPath: nil)
    }

    /**
     Transforms the input type AnyObject? and returns [`Type`] as output.
     
     - parameter input: The object to be transformed.
     
     - parameter keyPath: If input type allows, use the given key path as the root object.
     
     - returns: [`Type`]
     */
    open func transform(_ input: AnyObject?, keyPath: String?) -> [Type]? {
        guard let json = JSON(input) else { return nil }

        if let keyPath = keyPath, keyPath.count > 0, let json = json[keyPath] {
            return self.transformArray(json)
        }

        return self.transformArray(json)
    }

    /**
     Transforms `json` into [`U`].
     
     - parameter json: The `JSON` object to be transformed.
     
     - returns: [`Type`]
     */
    open func transformArray(_ json: JSON) -> [Type] {
        var items = [Type]()
        if let collection = json.collection {
            for jsonEntry in collection {
                var item = Type.init()
                item.deserialize(jsonEntry)
                items.append(item)
            }
        }
        return items
    }

}

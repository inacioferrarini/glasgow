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
import CoreData

@objc(TestEntity)
public class TestEntity: NSManagedObject {

    open class func testEntity(with name: String?, inManagedObjectContext context: NSManagedObjectContext) -> TestEntity? {
        let newTestEntity = NSEntityDescription.insertNewObject(forEntityName: self.simpleClassName(), into: context) as? TestEntity
        if let entity = newTestEntity {
            entity.name = name
        }
        return newTestEntity
    }
    
    open class func removeAll(inManagedObjectContext context: NSManagedObjectContext) {
        let request: NSFetchRequest = NSFetchRequest<TestEntity>(entityName: self.simpleClassName())
        if let searchResults = try? context.fetch(request) {
            for entity in searchResults {
                context.delete(entity)
            }
        }
    }

}
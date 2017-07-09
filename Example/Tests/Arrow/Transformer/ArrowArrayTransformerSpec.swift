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

class ArrowArrayTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Arrow Transformer Test") {
  
            it("must parse Persons data") {
                // Given
                let transformer = ArrowArrayTransformer<Person>()
                
                // When
                guard let fixtureData = FixtureHelper().arrayFixture(using: "PersonsFixture") else { fail("null fixture data"); return }
                guard let parsedPersonArray = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                
                // Then
                expect(parsedPersonArray).toNot(beNil())
                expect(parsedPersonArray.count).to(equal(3))
    
                expect(parsedPersonArray[0].name).to(equal("Fulano da Silva"))
                expect(parsedPersonArray[0].age).to(equal(35))
                expect(parsedPersonArray[0].boolValue).to(beTruthy())
                
                expect(parsedPersonArray[1].name).to(equal("Sincrano"))
                expect(parsedPersonArray[1].age).to(equal(40))
                expect(parsedPersonArray[1].boolValue).to(beFalsy())

                expect(parsedPersonArray[2].name).to(equal("Beltrano"))
                expect(parsedPersonArray[2].age).to(equal(37))
                expect(parsedPersonArray[2].boolValue).to(beTruthy())
            }
            
            it("must parse composed Persons data") {
                // Given
                let transformer = ArrowArrayTransformer<Person>()
                
                // When
                guard let fixtureData = FixtureHelper().objectFixture(using: "ComposedPersonsFixture") else { fail("null fixture data"); return }
                guard let parsedPersonArray = transformer.transform(fixtureData, keyPath: "data") else { fail("returned nil object"); return }
                
                // Then
                expect(parsedPersonArray).toNot(beNil())
                expect(parsedPersonArray.count).to(equal(3))

                expect(parsedPersonArray[0].name).to(equal("Fulano da Silva"))
                expect(parsedPersonArray[0].age).to(equal(35))
                expect(parsedPersonArray[0].boolValue).to(beTruthy())
                
                expect(parsedPersonArray[1].name).to(equal("Sincrano"))
                expect(parsedPersonArray[1].age).to(equal(40))
                expect(parsedPersonArray[1].boolValue).to(beFalsy())
                
                expect(parsedPersonArray[2].name).to(equal("Beltrano"))
                expect(parsedPersonArray[2].age).to(equal(37))
                expect(parsedPersonArray[2].boolValue).to(beTruthy())
            }
            
            it("must return nil when uncapable o parse") {
                // Given
                let transformer = ArrowArrayTransformer<Person>()
                
                // When
                let nilParsedPersonArray = transformer.transform(nil)
                
                // Then
                expect(nilParsedPersonArray).to(beNil())
            }
            
        }
        
    }
    
}

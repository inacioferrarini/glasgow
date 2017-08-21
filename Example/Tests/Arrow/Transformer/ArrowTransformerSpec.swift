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

class ArrowTransformerSpec: QuickSpec {

    override func spec() {

        describe("Arrow Transformer Test") {

            it("must parse Playlist data") {
                // Given
                let transformer = ArrowTransformer<Person>()

                // When
                guard let fixtureData = FixtureHelper().objectFixture(using: "PersonFixture") else { fail("null fixture data"); return }
                guard let parsedPerson = transformer.transform(fixtureData) else { fail("returned nil object"); return }

                // Then
                expect(parsedPerson).toNot(beNil())
                expect(parsedPerson.name).to(equal("Fulano da Silva"))
                expect(parsedPerson.age).to(equal(35))
                expect(parsedPerson.boolValue).to(equal(true))
            }

            it("must parse composed Playlist data") {
                // Given
                let transformer = ArrowTransformer<Person>()

                // When
                guard let fixtureData = FixtureHelper().objectFixture(using: "ComposedPersonFixture") else { fail("null fixture data"); return }
                guard let parsedPerson = transformer.transform(fixtureData, keyPath: "data") else { fail("returned nil object"); return }

                // Then
                expect(parsedPerson).toNot(beNil())
                expect(parsedPerson.name).to(equal("Fulano da Silva"))
                expect(parsedPerson.age).to(equal(35))
                expect(parsedPerson.boolValue).to(equal(true))
            }

            it("must return nil when uncapable o parse") {
                // Given
                let transformer = ArrowTransformer<Person>()

                // When
                let nilParsedPerson = transformer.transform(nil)

                // Then
                expect(nilParsedPerson).to(beNil())
            }

        }

    }

}

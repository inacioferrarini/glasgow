//
//  ArrayDataProviderSpec.swift
//  Glasgow
//
//  Created by José Inácio Athayde Ferrarini on 05/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import Glasgow

class ArrayDataProviderSpec: QuickSpec {
    
    override func spec() {
        
        describe("Array Data Provider") {
            
            var items = [Int]()
            var dataProvider = ArrayDataProvider<Int>(with: [])
            
            beforeEach {
                // Given
                items = [10, 20, 30]
                dataProvider = ArrayDataProvider<Int>(with: items)
            }
            
            it("Initialization must have given objects") {
                // Then
                expect(dataProvider.objects).toNot(beNil())
                expect(dataProvider.objects.count).to(equal(3))
            }
            
            it("Count must return the amount of store objects") {
                // Then
                expect(dataProvider.count).to(equal(3))
            }

            it("index must return the correct index") {
                // Then
                expect(dataProvider.index(of: 20)).to(equal(1))
            }
            
            it("subscript must return the correct object for given index") {
                // Then
                expect(dataProvider[0]).to(equal(10))
            }
            
        }
        
    }
    
}

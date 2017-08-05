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
            
        }
        
    }
}


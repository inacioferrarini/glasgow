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
import OHHTTPStubs
@testable import Glasgow

class AppBaseApiSpec: QuickSpec {
    
    override func spec() {
        
        describe("Base Api Request") {
            
            it("if request succeeds, must return valid object") {
                // Given
                stub(condition: isHost("www.apiurl.com")) { request in
                    let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
                    let error = OHHTTPStubsResponse(error:notConnectedError)
                    guard let fixtureFile = OHPathForFile("ApiRequestResponseFixture.json", type(of: self)) else { return error }
                    
                    return OHHTTPStubsResponse(
                        fileAtPath: fixtureFile,
                        statusCode: 200,
                        headers: ["Content-Type" : "application/json"]
                    )
                }
                
                
                var returnedPersonList: [Person]?
                let api = AppBaseApi("https://www.apiurl.com")
                let targetUrl = "/path"
                let transformer = ApiResponseToPersonArrayTransformer()
                
                // When
                waitUntil { done in
                    api.get(targetUrl,
                            responseTransformer: transformer,
                            success: { (persons) in
                        returnedPersonList = persons
                        done()
                    }, failure: { (error) in
                        fail("Mocked response returned error")
                        done()
                    }, retryAttempts: 30)
                }
                
                // Then
                expect(returnedPersonList?.count).to(equal(3))
                
                expect(returnedPersonList?[0].name).to(equal("Fulano da Silva"))
                expect(returnedPersonList?[0].age).to(equal(35))
                expect(returnedPersonList?[0].boolValue).to(equal(true))

                expect(returnedPersonList?[1].name).to(equal("Sincrano"))
                expect(returnedPersonList?[1].age).to(equal(40))
                expect(returnedPersonList?[1].boolValue).to(equal(false))

                expect(returnedPersonList?[2].name).to(equal("Beltrano"))
                expect(returnedPersonList?[2].age).to(equal(37))
                expect(returnedPersonList?[2].boolValue).to(equal(true))
            }
            
            it("if request fails, must execute failure block") {
                // Given
                stub(condition: isHost("www.apiurl.com")) { request in
                    let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
                    return OHHTTPStubsResponse(error: notConnectedError)
                }
                
                var returnedPlaylists: [Person]?
                let api = AppBaseApi("https://www.apiurl.com")
                let targetUrl = "/path"
                let transformer = ApiResponseToPersonArrayTransformer()
                
                // When
                waitUntil { done in
                    api.get(targetUrl,
                            responseTransformer: transformer,
                            success: { (playlists) in
                        fail("Mocked response returned success")
                        returnedPlaylists = playlists
                        done()
                    }, failure: { (error) in
                        done()
                    }, retryAttempts: 30)
                }
                
                // Then
                expect(returnedPlaylists).to(beNil())
            }
            
        }
        
    }
    
}

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
 Basic Api class.
 
 Handles remote HTTP requests using Apple APIs.
 */
open class AppBaseApi {
    
    
    // MARK: - Properties
    
    let rootUrl: String
    
    
    // MARK: - Initialization
    
    /**
     Inits the class using the given the root url.
     
     - parameter rootUrl: The  server base url.
     */
    public init(_ rootUrl: String) {
        self.rootUrl = rootUrl
    }
    
    
    // MARK: - Helper methods
    
    /**
     Performs a GET request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `error` block.
     */
    open func get<Type, TransformerType>(
        _ targetUrl: String,
        responseTransformer: TransformerType,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.get(targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: nil,
                 success: success,
                 failure: failure,
                 retryAttempts: retryAttempts)
    }
    
    /**
     Performs a GET request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter parameters: Parameters to be sent with the request.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `errorHandler` block.
     */
    open func get<Type, TransformerType>(
        _ targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.get(self.rootUrl,
                 targetUrl: targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: parameters,
                 success: success,
                 failure: failure,
                 retryAttempts: retryAttempts)
    }
    
    /**
     Performs a GET request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter _: The  server base url.
     **This parameters overrides the `AppBaseApi`'s init parameter value for this request.**
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter parameters: Parameters to be sent with the request.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `errorHandler` block.
     */
    open func get<Type, TransformerType>(
        _ endpointUrl: String,
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.operation(httpMethod: "GET",
                       endpointUrl,
                       targetUrl: targetUrl,
                       responseTransformer: responseTransformer,
                       parameters: parameters,
                       success: success,
                       failure: failure,
                       retryAttempts: retryAttempts)
    }


    // MARK: - POST
    
    /**
     Performs a POST request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `error` block.
     */
    open func post<Type, TransformerType>(
        _ targetUrl: String,
        responseTransformer: TransformerType,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.post(targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: nil,
                 success: success,
                 failure: failure,
                 retryAttempts: retryAttempts)
    }
    
    /**
     Performs a POST request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter parameters: Parameters to be sent with the request.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `errorHandler` block.
     */
    open func post<Type, TransformerType>(
        _ targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.post(self.rootUrl,
                 targetUrl: targetUrl,
                 responseTransformer: responseTransformer,
                 parameters: parameters,
                 success: success,
                 failure: failure,
                 retryAttempts: retryAttempts)
    }
    
    /**
     Performs a POST request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter _: The  server base url.
     **This parameters overrides the `AppBaseApi`'s init parameter value for this request.**
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter parameters: Parameters to be sent with the request.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `errorHandler` block.
     */
    open func post<Type, TransformerType>(
        _ endpointUrl: String,
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        self.operation(httpMethod: "POST",
                       endpointUrl,
                       targetUrl: targetUrl,
                       responseTransformer: responseTransformer,
                       parameters: parameters,
                       success: success,
                       failure: failure,
                       retryAttempts: retryAttempts)
    }

    
    // MARK: - Helper methods
    
    /**
     Performs a httpMethod kind request to the given path.
     If the requests succeeds, the `completion` block will be called after converting the result
     using the given transformer.
     If the request fails, the 'errorHandler' block will be called instead.
     
     - parameter httpMethod: Http method to execute.
     
     - parameter _: The  server base url.
     **This parameters overrides the `AppBaseApi`'s init parameter value for this request.**
     
     - parameter targetUrl: The request path.
     
     - parameter responseTransformer: the `Transformer` that will be used to transform the returned value
     from the request into the object the `completion` expects.
     
     - parameter parameters: Parameters to be sent with the request.
     
     - parameter success: The block to be called if request succeeds.
     
     - parameter failure: The block to be called if request fails.
     
     - parameter retryAttempts: How many tries before calling `errorHandler` block.
     */
    open func operation<Type, TransformerType>(
        httpMethod: String,
        _ endpointUrl: String,
        targetUrl: String,
        responseTransformer: TransformerType,
        parameters: [String : AnyObject]?,
        success: @escaping ((Type) -> Void),
        failure: @escaping ((Error) -> Void),
        retryAttempts: Int) where TransformerType : Transformer, TransformerType.T == AnyObject?, TransformerType.U == Type {
        
        let urlString = endpointUrl + targetUrl
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = URL(string: urlString) else { return }
        
        let request = self.requestBody(httpMethod: httpMethod, url: url, parameters: parameters)
        
        let postTask = defaultSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                if retryAttempts <= 1 {
                    failure(error)
                }
                else {
                    self.operation(httpMethod: httpMethod,
                                   endpointUrl,
                                   targetUrl: targetUrl,
                                   responseTransformer: responseTransformer,
                                   parameters: parameters,
                                   success: success,
                                   failure: failure,
                                   retryAttempts: retryAttempts - 1)
                }
            }
            else if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
                guard let data = data else { return }
                guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject else { return }
                
                let transformedObject = responseTransformer.transform(jsonData)
                success(transformedObject)
            }
        }
        
        postTask.resume()
    }
    
    func requestBody(httpMethod: String,
                     url: URL,
                     parameters: [String : AnyObject]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        return request
    }
    
}

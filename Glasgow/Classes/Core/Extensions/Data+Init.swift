//
//  Data+Stream.swift
//  Glasgow
//
//  Created by Inacio Ferrarini on 11/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

public extension Data {

    /**
     Adds a new Init capable of reading a InputStream.
     
     - parameter input: `InputStream` to read data from.
    */
    public init(reading input: InputStream) {
        self.init()
        input.open()
        
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            self.append(buffer, count: read)
        }
        buffer.deallocate(capacity: bufferSize)
        input.close()
    }
    
}

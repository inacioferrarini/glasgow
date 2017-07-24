//
//  Person.swift
//  Glasgow
//
//  Created by Inacio Ferrarini on 07/07/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Arrow

struct Person {
    var name: String?
    var age: Int?
    var boolValue: Bool?
}

extension Person : ArrowParsable {
    
    mutating func deserialize(_ json: JSON) {
        name <-- json["name"]
        age <-- json["age"]
        boolValue <-- json["boolValue"]
    }
    
}

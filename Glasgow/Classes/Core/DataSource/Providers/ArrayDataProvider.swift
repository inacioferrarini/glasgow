//
//  ArrayDataProvider.swift
//  Pods
//
//  Created by José Inácio Athayde Ferrarini on 05/08/17.
//
//

import UIKit

/**
 Array-based generic data provider having elements of type `Type`.
 */
open class ArrayDataProvider<Type: Equatable>: DataProvider {

    
    // MARK: - Properties
    
    /**
     Objects from this provider.
     */
    public var objects: [Type]
    
    
    // MARK: - Initialization
    
    /**
     Inits with given objects.
     
     - parameter objects: The objects to be contained.
     */
    public init(with objects: [Type]) {
        self.objects = objects
    }
    
}

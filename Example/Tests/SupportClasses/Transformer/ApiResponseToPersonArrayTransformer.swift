//
//  PlaylistResponseToPlaylistArrayTransformer.swift
//  NetworkingArrow
//
//  Created by Inacio Ferrarini on 02/07/17.
//  Copyright © 2017 br.com.inacio. All rights reserved.
//

import Foundation
import Arrow
@testable import Glasgow

class PlaylistResponseToPlaylistArrayTransformer: Transformer {
    
    func transform(_ input: AnyObject?, keyPath: String?) -> [Person]? {
        return ArrowArrayTransformer<Person>().transform(input, keyPath: "data")
    }

}

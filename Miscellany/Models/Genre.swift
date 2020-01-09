//
//  GenreModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseGenre: Codable {
    var id: String
    
    var title: String
    var storyCount: Int
}

struct Genre: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var description: String
    
    var storyCount: Int
}

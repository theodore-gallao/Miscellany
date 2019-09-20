//
//  GenreModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

struct GenreModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var name: String
    var description: String
    var imageUrl: URL?
}

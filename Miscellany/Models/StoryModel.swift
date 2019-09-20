//
//  StoryModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

struct StoryModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var description: String
    var author: UserModel
    var genres: [GenreModel]
    var tags: [String]
    
    var coverImageUrl: URL?
    var text: String
    
    var rating: Double
    var viewCount: Int
    var commentCount: Int
    
}

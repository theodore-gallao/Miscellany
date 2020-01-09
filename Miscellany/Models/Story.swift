//
//  StoryModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseStory: Codable {
    var id: String
    
    var title: String
    var author: BaseUser
}

struct Story: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var description: String
    var author: BaseUser
    var genre: Genre
    var tags: [Tag]?
    
    var text: String
    
    var readCount: Int
    var likeCount: Int
    var dislikeCount: Int
    
    var commentCount: Int
    var comments: [Comment]?
    
    var awards: [Award]?
    
    var rank: Int?
}

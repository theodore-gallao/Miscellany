//
//  StoryModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

enum Genre: String, CaseIterable, Codable {
    case all = "All"
    case adventure = "Adventure"
    case dystopian = "Dystopian"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case mystery = "Mystery"
    case romance = "Romance"
    case sciFi = "Sci-Fi"
    case thriller = "Thriller"
    case western = "Western"
}

struct StoryModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var description: String
    var author: UserModel
    var genre: Genre
    var tags: [String]?
    
    var text: String
    
    var viewCount: Int
    var likeCount: Int
    var dislikeCount: Int
    
    var commentCount: Int
    var comments: [CommentModel]?
    
    var awards: [AwardModel]?
}

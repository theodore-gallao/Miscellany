//
//  CommentModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

struct CommentModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var user: UserModel
    
    var text: String
    
    var likeCount: Int
    var dislikeCount: Int
    
    var replyCount: Int
    var parentId: String?
    
}

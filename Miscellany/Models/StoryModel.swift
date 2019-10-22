//
//  StoryModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseStoryModel: Codable {
    var id: String
    
    var title: String
    var author: BaseUserModel
}

struct StoryModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var description: String
    var author: BaseUserModel
    var genre: GenreModel
    var tags: [TagModel]?
    
    var text: String
    
    var readCount: Int
    var likeCount: Int
    var dislikeCount: Int
    
    var commentCount: Int
    var comments: [CommentModel]?
    
    var awards: [AwardModel]?
    
    var rank: Int?
}

extension BaseStoryModel: Itemable {
    var itemImage: (UIImageView?) -> Void {
        return { imageView in
            _ = ImageService.shared.download(directory: .stories, id: self.id) { (result) in
                switch result {
                case .success(let image):
                    imageView?.image = image
                case .failure(let error):
                    print(error)
                    imageView?.image = nil
                }
            }
        }
    }
    
    var itemHeadline: String? {
        return nil
    }
    
    var itemTitle: String? {
        return self.title
    }
    
    var itemSubtitle: String? {
        return self.author.firstName + " " + self.author.lastName
    }
}

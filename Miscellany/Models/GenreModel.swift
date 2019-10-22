//
//  GenreModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseGenreModel: Codable {
    var id: String
    
    var title: String
    var storyCount: Int
}

struct GenreModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var description: String
    
    var storyCount: Int
}

extension BaseGenreModel: Itemable {
    var itemImage: (UIImageView?) -> Void {
        return { imageView in
            _ = ImageService.shared.download(directory: .genres, id: self.id) { (result) in
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
        return self.storyCount.formatted
    }
}

//
//  TagModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/10/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseTagModel {
    var id: String
    
    var title: String
    var storyCount: Int
}

struct TagModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    
    var storyCount: Int
}

extension BaseTagModel: Itemable {
    var itemImage: (UIImageView?) -> Void {
        return { imageView in
            imageView?.image = UIImage(named: "Tag")
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

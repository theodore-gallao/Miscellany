//
//  UserModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseUserModel: Codable {
    var id: String
    
    var firstName: String
    var lastName: String
    
    var subscriberCount: Int
}

struct UserModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var firstName: String
    var lastName: String
    
    var storyCount: Int
    
    var subscriberCount: Int
    var subscribedCount: Int
}

extension BaseUserModel: Itemable {
    var itemImage: (UIImageView?) -> Void {
        return { imageView in
            _ = ImageService.shared.download(directory: .users, id: self.id) { (result) in
                switch result {
                case .success(let image):
                    imageView?.image = image.circleMasked
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
        return self.firstName + " " + self.lastName
    }
    
    var itemSubtitle: String? {
        return self.subscriberCount.formatted
    }
}

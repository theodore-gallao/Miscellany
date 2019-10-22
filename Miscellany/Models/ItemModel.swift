//
//  ItemModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/17/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct ItemModel: Itemable {
    var image: (UIImageView?) -> Void
    var headline: String?
    var title: String?
    var subtitle: String?
    
    var itemImage: (UIImageView?) -> Void {
        return self.image
    }
    
    var itemHeadline: String? {
        return self.headline
    }
    
    var itemTitle: String? {
        return self.title
    }
    
    var itemSubtitle: String? {
        return self.subtitle
    }
}

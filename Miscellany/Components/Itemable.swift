//
//  Item.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/16/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

protocol Itemable {
    var itemImage: (UIImageView?) -> Void { get }
    
    var itemHeadline: String? { get }
    
    var itemTitle: String? { get }
    
    var itemSubtitle: String? { get }
}

//
//  UICollectionReusableView+.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/26/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionReusableView {
    enum Id: String {
        case header = "HEADER_COLLECTION_REUSABLE_VIEW_ID"
        case groupHeader = "GROUP_HEADER_COLLECTION_REUSABLE_VIEW_ID"
    }
    
    enum Kind: String {
        case header = "HEADER_COLLECTION_REUSABLE_VIEW_KIND"
        case groupHeader = "GROUP_HEADER_COLLECTION_REUSABLE_VIEW_KIND"
    }
}

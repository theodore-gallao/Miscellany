//
//  UICollectionViewCell+.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/26/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    enum Id: String {
        case regular = "REGULAR_COLLECTION_VIEW_CELL_ID"
        case large = "LARGE_COLLECTION_VIEW_CELL_ID"
        case ranked = "RANKED_COLLECTION_VIEW_CELL_ID"
        case preview = "PREVIEW_COLLECTION_VIEW_CELL_ID"
        case award = "AWARD_COLLECTION_VIEW_CELL_ID"
    }
}

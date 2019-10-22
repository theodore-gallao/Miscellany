//
//  Likeable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

protocol Likable {
    var likeCount: Int { get set }
    var dislikeCount: Int { get set }
    
    var likePercentage: Double { get }
}

extension Likable {
    var likePercentage: Double {
        return Double(self.likeCount) / Double(self.dislikeCount)
    }
}

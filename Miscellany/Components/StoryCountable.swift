//
//  StoryCountable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Objects that conform to this protocol can reference a count of stories. Such examples include stories that a user authors, or the number of stories in a tag.
protocol StoryCountable {
    
    /// The number of stories referenced by this object
     var storyCount: Int { get set }
}

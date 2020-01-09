//
//  Headline.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/2/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseHeadline {
    var id: String
    var type: Headline.HeadlineType
    var targetId: String
    var heading: String
    var title: String
    var subtitle: String
}

struct Headline: Databasable, Hashable {
    enum HeadlineType: Int, Codable {
        case article
        case contest
        case story
        case user
        case genre
        case tag
    }
    
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var type: HeadlineType
    var targetId: String
    var heading: String
    var title: String
    var subtitle: String
}

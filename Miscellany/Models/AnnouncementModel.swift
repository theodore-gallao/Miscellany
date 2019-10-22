//
//  AnnouncementModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/2/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct AnnouncementModel: Databasable {
    enum AnnouncementType: Int, Codable {
        case article
        case contest
        case story
        case author
    }
    
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var type: AnnouncementType
    var title: String
    var heading: String
    var subheading: String
}

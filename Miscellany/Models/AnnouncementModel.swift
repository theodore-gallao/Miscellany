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
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var headline: String
    var subheadline: String
}

//
//  Section.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

enum SectionDisplayType: Int, Codable {
    case regular
    case large
    case ranked
}

struct SectionModel: Databasable {
    // Identifiable
    var id: String
    
    // Datable
    var dateCreated: Date
    var dateUpdated: Date
    
    // Category
    var displayType: SectionDisplayType
    var name: String
    var description: String
    var moreDescription: String?
}

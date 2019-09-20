//
//  Datable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

protocol Datable {
    var dateCreated: Date { get set }
    var dateUpdated: Date { get set }
}

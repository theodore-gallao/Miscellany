//
//  Double+.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/17/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

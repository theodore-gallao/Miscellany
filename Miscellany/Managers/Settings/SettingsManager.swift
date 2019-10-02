//
//  SettingsManager.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager(textSettings: TextSettings.shared)
    
    let textSettings: TextSettings
    
    private init(textSettings: TextSettings) {
        self.textSettings = textSettings
    }
    
    func configure() {
        self.textSettings.configure()
    }
}

//
//  TextOptionsViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/18/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class TextSettingsViewController: UIViewController {
    var textSettings: TextSettingsModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.textSettings = TextSettingsModel(id: <#T##String#>, dateCreated: <#T##Date#>, dateUpdated: <#T##Date#>)
    }
}

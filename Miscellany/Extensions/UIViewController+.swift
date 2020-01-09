//
//  UIViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/1/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var displayMode: DisplayMode {
        return DisplayMode.displayMode(for: self.view.frame.width)
    }
}

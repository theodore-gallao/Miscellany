//
//  TextSettings.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/18/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class TextSettings {
    static let shared = TextSettings()
    
    private init() {}
    
    func configure() {}
    
    enum LineSpacing: CaseIterable {
        case compact
        case standard
        case extra
    }

    enum FontType: CaseIterable {
        case avenir
        case baskerville
        case `default`
        case georgia
        case helveticaNeue
        case hoeflerText
        case palatino
        case verdana
    }
    
    var textSize: CGFloat = 16
    
    var textFontType: FontType = .default {
        didSet {
            self.textFont = self.font(type: self.textFontType) ?? UIFont.systemFont(ofSize: self.textSize, weight: UIFont.Weight.regular)
            self.textFontIndex = self.fontIndex(type: self.textFontType)
        }
    }
    
    var lineSpacing: LineSpacing = .standard
    
    private(set) var textFont: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
    private(set) var textFontIndex: Int = 2
    
    func font(type: FontType) -> UIFont? {
        switch (type) {
        case .avenir: return UIFont(name: "Avenir-Medium", size: self.textSize)
        case .baskerville: return UIFont(name: "Baskerville", size: self.textSize)
        case .default: return UIFont.systemFont(ofSize: self.textSize, weight: UIFont.Weight.regular)
        case .georgia: return UIFont(name: "Georgia", size: self.textSize)
        case .helveticaNeue: return UIFont(name: "HelveticaNeue", size: self.textSize)
        case .hoeflerText: return UIFont(name: "HoeflerText-Regular", size: self.textSize)
        case .palatino: return UIFont(name: "Palatino-Roman", size: self.textSize)
        case .verdana: return UIFont(name: "Verdana", size: self.textSize)
        }
    }
    
    func fontIndex(type: FontType) -> Int {
        switch (type) {
        case .avenir: return 0
        case .baskerville: return 1
        case .default: return 2
        case .georgia: return 3
        case .helveticaNeue: return 4
        case .hoeflerText: return 5
        case .palatino: return 6
        case .verdana: return 7
        }
    }
}

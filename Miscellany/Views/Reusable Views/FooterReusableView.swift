//
//  FooterReusableView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/13/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class FooterReusableView: GenericReusableView {
    // Views
    private let moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Primary")
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Constraints
    private var moreButtonConstraints = [NSLayoutConstraint]()
    
    // Initializer
    override func commonInit() {
        super.commonInit()
        
        self.addSubview(self.moreButton)
        
        self.configureLayout()
    }
    
    // Setter
    public func set(title: String?) {
        self.moreButton.setTitle(title ?? "More", for: .normal)
    }
}

// MARK: Layout & Constraints
extension FooterReusableView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.deactivate(self.moreButtonConstraints)
        
        self.moreButtonConstraints = [
            self.moreButton.topAnchor
                .constraint(equalTo: self.topAnchor, constant: 16),
            self.moreButton.leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 0),
            self.moreButton.trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: 0),
            self.moreButton.bottomAnchor
                .constraint(equalTo: self.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(self.moreButtonConstraints)
    }
}


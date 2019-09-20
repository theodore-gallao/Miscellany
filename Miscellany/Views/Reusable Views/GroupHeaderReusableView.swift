//
//  GroupHeaderReusableView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/20/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class GroupHeaderReusableView: GenericReusableView {
    // Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Constraints
    internal var titleLabelConstraints = [NSLayoutConstraint]()
    
    // Initializer
    override func commonInit() {
        super.commonInit()
        
        self.addSubview(self.titleLabel)
        
        self.configureLayout()
    }
    
    // Setter
    public func set(title: String) {
        self.titleLabel.text = title
    }
}

// MARK: Layout & Constraints
extension GroupHeaderReusableView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        
        self.titleLabelConstraints = [
            self.titleLabel.centerYAnchor
                .constraint(equalTo: self.centerYAnchor, constant: 0),
            self.titleLabel.leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: 0),
        ]
        
        NSLayoutConstraint.activate(self.titleLabelConstraints)
    }
}

//
//  HeaderView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/9/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class HeaderView: BaseView {
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    internal let moreArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: UIImage.SymbolWeight.semibold)))
        imageView.tintColor = UIColor(named: "Primary")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // Constraints
    internal var titleLabelConstraints = [NSLayoutConstraint]()
    internal var subtitleLabelConstraints = [NSLayoutConstraint]()
    internal var moreArrowImageViewConstraints = [NSLayoutConstraint]()
    
    // Setter
    public func set(title: String) {
        self.titleLabel.text = title
    }
}

// MARK: Layout & Constraints
extension HeaderView {
    override func configureViews() {
        super.configureViews()
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.moreArrowImageView)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.moreArrowImageViewConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.moreArrowImageViewConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.titleLabelConstraints = [
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        self.moreArrowImageViewConstraints = [
            self.moreArrowImageView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0),
            self.moreArrowImageView.widthAnchor.constraint(equalTo: self.moreArrowImageView.widthAnchor, constant: 0),
            self.moreArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 0)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ]
        
        self.moreArrowImageViewConstraints = [
            self.moreArrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.moreArrowImageView.widthAnchor.constraint(equalTo: self.moreArrowImageView.widthAnchor, constant: 0),
            self.moreArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 0)
        ]
    }
    
    override func configureViewsForCompactSizeClass() {
        super.configureViewsForCompactSizeClass()
    }
    
    override func configureViewsForRegularSizeClass() {
        super.configureViewsForRegularSizeClass()
    }
}

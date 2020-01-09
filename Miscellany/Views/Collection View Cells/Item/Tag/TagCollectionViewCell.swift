//
//  TagCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/5/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class TagCollectionViewCell: ItemCollectionViewCell {
    func set(baseTag: BaseTag) {
        self.titleLabel.text = "\(baseTag.title)"
        self.subtitleLabel.text = "\(baseTag.storyCount.formatted) stories"
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = UIImage(named: "Tag")
        self.imageView.tintColor = UIColor(named: "Subtext")
        
        self.layoutIfNeeded()
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
    }
}

// MARK: Views, Layout & Constraints
extension TagCollectionViewCell {
    override func configureViews() {
        super.configureViews()
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.subtitleLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.subtitleLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 1),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 1),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
    }
}

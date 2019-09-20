//
//  LargeStoryCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/13/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class LargeStoryCollectionViewCell: RegularStoryCollectionViewCell {
    internal let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Subtext")
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        return label
    }()
    
    internal var descriptionLabelConstraints = [NSLayoutConstraint]()
    
    override func commonInit() {
        self.addSubview(self.descriptionLabel)
        
        self.titleLabel.numberOfLines = 2
        self.authorLabel.numberOfLines = 2
        
        super.commonInit()
        
        self.configureLayout()
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        NSLayoutConstraint.deactivate(self.coverImageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorLabelConstraints)
        NSLayoutConstraint.deactivate(self.descriptionLabelConstraints)
        
        self.coverImageViewConstraints = [
            self.coverImageView.topAnchor
                .constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.coverImageView.widthAnchor
                .constraint(equalTo: self.coverImageView.heightAnchor, multiplier: (6 / 9)),
            self.coverImageView.leadingAnchor
                .constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.coverImageView.bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor
                .constraint(equalTo: self.coverImageView.topAnchor, constant: 0),
            self.titleLabel.leadingAnchor
                .constraint(equalTo: self.coverImageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor
                .constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor
                .constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.authorLabel.leadingAnchor
                .constraint(equalTo: self.titleLabel.leadingAnchor, constant: 0),
            self.authorLabel.trailingAnchor
                .constraint(equalTo: self.titleLabel.trailingAnchor, constant: 0)
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor
                .constraint(equalTo: self.authorLabel.bottomAnchor, constant: 0),
            self.descriptionLabel.leadingAnchor
                .constraint(equalTo: self.titleLabel.leadingAnchor, constant: 0),
            self.descriptionLabel.trailingAnchor
                .constraint(equalTo: self.titleLabel.trailingAnchor, constant: 0),
            self.descriptionLabel.bottomAnchor
                .constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(self.coverImageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorLabelConstraints)
        NSLayoutConstraint.activate(self.descriptionLabelConstraints)
    }
    
    override func set(_ storyModel: StoryModel) {
        super.set(storyModel)
        
        self.descriptionLabel.text = "----\n\(storyModel.description)"
    }
}

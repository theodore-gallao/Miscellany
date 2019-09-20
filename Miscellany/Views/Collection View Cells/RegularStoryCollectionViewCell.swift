//
//  RegularStoryCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class RegularStoryCollectionViewCell: GenericCollectionViewCell {
    // MARK: Views
    internal let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Story Title"
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        
        return label
    }()
    
    internal let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Author Name"
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        
        return label
    }()
    
    // MARK: Initializers
    override func commonInit() {
        super.commonInit()
        
        self.contentView.addSubview(self.coverImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.authorLabel)
        
        self.configureLayout()
    }
    
    internal func set(_ storyModel: StoryModel) {
        self.titleLabel.text = storyModel.title
        self.authorLabel.text = storyModel.author.firstName + " " + storyModel.author.lastName
    }
    
    // MARK: THIS IS FOR TESTING PURPOSES ONLY. WILL DELETE AT LAUNCH
    internal func set(_ image: UIImage?) {
        self.coverImageView.image = image
    }
    
    // MARK: Layout & Constraints
    internal var coverImageViewConstraints = [NSLayoutConstraint]()
    internal var titleLabelConstraints = [NSLayoutConstraint]()
    internal var authorLabelConstraints = [NSLayoutConstraint]()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    internal func configureLayout() {
        NSLayoutConstraint.deactivate(self.coverImageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorLabelConstraints)
        
        self.coverImageViewConstraints = [
            self.coverImageView.topAnchor
                .constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.coverImageView.leadingAnchor
                .constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.coverImageView.trailingAnchor
                .constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.coverImageView.heightAnchor
                .constraint(equalTo: self.coverImageView.widthAnchor, multiplier: (9 / 6))
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor
                .constraint(equalTo: self.coverImageView.bottomAnchor, constant: 8),
            self.titleLabel.leadingAnchor
                .constraint(equalTo: self.coverImageView.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor
                .constraint(equalTo: self.coverImageView.trailingAnchor, constant: 0),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor
                .constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.authorLabel.leadingAnchor
                .constraint(equalTo: self.coverImageView.leadingAnchor, constant: 0),
            self.authorLabel.trailingAnchor
                .constraint(equalTo: self.coverImageView.trailingAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(self.coverImageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorLabelConstraints)
    }
}

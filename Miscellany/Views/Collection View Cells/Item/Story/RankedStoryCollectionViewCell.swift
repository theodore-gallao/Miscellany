//
//  RankedStoryCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/23/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class RankedStoryCollectionViewCell: StoryCollectionViewCell {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    private var rankLabelConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.rankLabel.text = ""
    }
    
    func set(baseStory: BaseStory, rank: Int, imageService: ImageService = .shared) {
        super.set(baseStory: baseStory)
        
        self.rankLabel.text = "\(rank.formatted)"
    }
}

// MARK: View, Layout & Constraints
extension RankedStoryCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.rankLabel)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorNameLabelConstraints)
        
        NSLayoutConstraint.deactivate(self.rankLabelConstraints)
    }
    
    override func configureLayout() {
        super.configureLayout()
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorNameLabelConstraints)
        
        NSLayoutConstraint.activate(self.rankLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 6 / 9),
            self.imageView.leadingAnchor.constraint(equalTo: self.rankLabel.trailingAnchor, constant: 10),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 1),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.rankLabelConstraints = [
            self.rankLabel.widthAnchor.constraint(equalToConstant: 30),
            self.rankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.rankLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 6 / 9),
            self.imageView.leadingAnchor.constraint(equalTo: self.rankLabel.trailingAnchor, constant: 10),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 1),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.rankLabelConstraints = [
            self.rankLabel.widthAnchor.constraint(equalToConstant: 24),
            self.rankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.rankLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ]
    }
}

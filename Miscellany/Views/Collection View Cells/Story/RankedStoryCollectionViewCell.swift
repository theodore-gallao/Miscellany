//
//  CompactStoryCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/13/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class RankedStoryCollectionViewCell: RegularStoryCollectionViewCell {
    internal let rankLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.heavy)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    internal var rankLabelConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.rankLabel.text?.removeAll()
    }
    
    override func configureViews() {
        super.configureViews()
    
        self.contentView.addSubview(self.rankLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        NSLayoutConstraint.deactivate(self.rankLabelConstraints)
        NSLayoutConstraint.deactivate(self.coverImageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorLabelConstraints)
        
        self.rankLabelConstraints = [
            self.rankLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.rankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        ]
        
        self.coverImageViewConstraints = [
            self.coverImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.coverImageView.widthAnchor.constraint(equalTo: self.coverImageView.heightAnchor, multiplier: (6 / 9)),
            self.coverImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32),
            self.coverImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.coverImageView.trailingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 1),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(self.rankLabelConstraints)
        NSLayoutConstraint.activate(self.coverImageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorLabelConstraints)
    }
    
    internal func set(_ rank: Int) {
        self.rankLabel.text = "\(rank)"
    }
}

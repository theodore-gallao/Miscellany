//
//  GenreCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/5/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class GenreCollectionViewCell: ItemCollectionViewCell {
    func set(baseGenre: BaseGenre) {
        self.titleLabel.text = baseGenre.title
        self.subtitleLabel.text = "\(baseGenre.storyCount.formatted) stories"
        self.imageView.image = UIImage(named: baseGenre.title)
    }
}

// MARK: Views, Layout & Constraints
extension GenreCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.titleLabel.numberOfLines = 1
        self.subtitleLabel.numberOfLines = 1
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
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 2 / 3)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 4),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 2 / 3)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 4),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
    }
}

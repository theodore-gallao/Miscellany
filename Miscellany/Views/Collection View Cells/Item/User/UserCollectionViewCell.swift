//
//  UserCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/5/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class UserCollectionViewCell: ItemCollectionViewCell {
    func set(baseUser: BaseUser) {
        self.titleLabel.text = "\(baseUser.firstName) \(baseUser.lastName)"
        self.subtitleLabel.text = "@\(baseUser.username)"
        
        self.imageView.backgroundColor = .clear
        
        self.configureLayout()
        
        DispatchQueue(label: "image", qos: .utility).async {
            let image = UIImage(named: "User \(baseUser.id)")?.resized(to: CGSize(width: 512, height: 512))?.circleMasked
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}

// MARK: Views, Layout & Constraints
extension UserCollectionViewCell {
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

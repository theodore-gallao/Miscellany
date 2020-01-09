//
//  NotificationCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/5/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class NotificationCollectionViewCell: ItemCollectionViewCell {
    private(set) var notification: Notification?
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "Primary")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    var headingLabelConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
        
        self.headingLabel.text = ""
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
    }
    
    func set(notification: Notification) {
        self.notification = notification
        
        self.headingLabel.text = notification.type.rawValue.uppercased()
        self.titleLabel.text = notification.title
        self.subtitleLabel.text = notification.subtitle
        
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 6
        
        if notification.isSeen {
            self.imageView.backgroundColor = .clear
            self.headingLabel.textColor = UIColor(named: "Subtext")
            self.titleLabel.textColor = UIColor(named: "Subtext")
        } else {
            self.imageView.backgroundColor = UIColor(named: "Primary")
            self.headingLabel.textColor = UIColor(named: "Primary")
            self.titleLabel.textColor = UIColor(named: "Text")
        }
    }
}

// MARK: Views, Layout & Constraints
extension NotificationCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.headingLabel)
        
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        self.subtitleLabel.numberOfLines = 3
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.headingLabelConstraints)
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.subtitleLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.headingLabelConstraints)
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.subtitleLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.centerYAnchor.constraint(equalTo: self.headingLabel.centerYAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 12),
            self.imageView.widthAnchor.constraint(equalToConstant: 12),
        ]
        
        self.headingLabelConstraints = [
            self.headingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headingLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.headingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: 2),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor)
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

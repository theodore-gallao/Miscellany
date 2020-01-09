//
//  HeadlineCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/24/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class HeadlineCollectionViewCell: BaseCollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.tertiarySystemFill
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return imageView
    }()
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    var imageViewConstraints = [NSLayoutConstraint]()
    var headingLabelConstraints = [NSLayoutConstraint]()
    var titleLabelConstraints = [NSLayoutConstraint]()
    var subtitleLabelConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
        
        self.headingLabel.text = ""
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
    }
    
    func set(headline: BaseHeadline, imageService: ImageService = .shared) {
        self.headingLabel.text = headline.heading
        self.titleLabel.text = headline.title
        self.subtitleLabel.text = headline.subtitle
        self.imageView.image = UIImage(named: "Announcement \(headline.id)")
    }
}

// MARK: View, Layout & Constraints
extension HeadlineCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.headingLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.headingLabelConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.subtitleLabelConstraints)
    }
    
    override func configureLayout() {
        super.configureLayout()
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.headingLabelConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.subtitleLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 6 / 9),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.headingLabelConstraints = [
            self.headingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: 2),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.imageView.topAnchor, constant: -10)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 6 / 9),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.headingLabelConstraints = [
            self.headingLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: 2),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.imageView.topAnchor, constant: -10)
        ]
    }
}

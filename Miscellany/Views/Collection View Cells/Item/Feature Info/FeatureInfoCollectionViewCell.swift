//
//  FeatureInfoCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/3/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class FeatureInfoCollectionViewCell: BaseCollectionViewCell {
    private(set) var feature: FeatureInfoModel?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(named: "Primary")
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    let subheadlineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var titleLabelConstraints = [NSLayoutConstraint]()
    var headlineLabelConstraints = [NSLayoutConstraint]()
    var subheadlineLabelConstraints = [NSLayoutConstraint]()
    var imageViewConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text?.removeAll()
        self.headlineLabel.text?.removeAll()
        self.subheadlineLabel.text?.removeAll()
        
        self.imageView.image = nil
    }
    
    func set(_ feature: FeatureInfoModel) {
        self.feature = feature
        
        self.titleLabel.text = feature.feature
        self.headlineLabel.text = feature.headline
        self.subheadlineLabel.text = feature.description
        self.imageView.image = feature.image
    }
}

extension FeatureInfoCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.headlineLabel)
        self.contentView.addSubview(self.subheadlineLabel)
        self.contentView.addSubview(self.imageView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.headlineLabelConstraints)
        NSLayoutConstraint.deactivate(self.subheadlineLabelConstraints)
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.headlineLabelConstraints = [
            self.headlineLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.headlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.subheadlineLabelConstraints = [
            self.subheadlineLabel.topAnchor.constraint(equalTo: self.headlineLabel.bottomAnchor, constant: 2),
            self.subheadlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.subheadlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.imageViewConstraints = [
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 6 / 9),
            self.imageView.topAnchor.constraint(equalTo: self.subheadlineLabel.bottomAnchor, constant: 10),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.headlineLabelConstraints)
        NSLayoutConstraint.activate(self.subheadlineLabelConstraints)
        NSLayoutConstraint.activate(self.imageViewConstraints)
    }
}

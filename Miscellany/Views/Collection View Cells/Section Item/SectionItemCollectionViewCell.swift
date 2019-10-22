//
//  SectionItemCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/16/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class SectionItemCollectionViewCell: BaseCollectionViewCell {
    enum Configuration {
        case standard
        case large
        case list
        case ranked
    }
    
    private var item: Itemable?
    private var properties: ItemProperties?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let headlineLabel: UILabel = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
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
    
    private var imageViewConstraints = [NSLayoutConstraint]()
    private var headlineLabelConstraints = [NSLayoutConstraint]()
    private var titleLabelConstraints = [NSLayoutConstraint]()
    private var subtitleLabelConstraints = [NSLayoutConstraint]()
    
    func set(_ item: Itemable, properties: ItemProperties, displayMode: DisplayMode) {
        self.item = item
        self.properties = properties
        
        item.itemImage(self.imageView)
        self.imageView.layer.cornerRadius = properties.imageCornerRadius.value(for: displayMode)
        
        self.headlineLabel.alpha = properties.headlineAlpha
        self.headlineLabel.text = item.itemHeadline
        self.headlineLabel.textAlignment = properties.textAlignment
        self.headlineLabel.textColor = properties.headlineTextColor
        self.headlineLabel.font = properties.headlineFont
        
        self.titleLabel.text = item.itemTitle
        self.titleLabel.textAlignment = properties.textAlignment
        self.titleLabel.font = properties.titleFont
        
        self.subtitleLabel.text = item.itemSubtitle
        self.subtitleLabel.textAlignment = properties.textAlignment
        
        self.configureLayout()
        self.layoutIfNeeded()
    }
}

// MARK: View, Layout & Constraints
extension SectionItemCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.headlineLabel)
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
    }
    
    override func configureViewsForCompactSizeClass() {
        super.configureViewsForCompactSizeClass()
    }
    
    override func configureViewsForRegularSizeClass() {
        super.configureViewsForRegularSizeClass()
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.headlineLabelConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.subtitleLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.headlineLabelConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.subtitleLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        switch self.properties?.configuration {
        case .standard:
            self.layoutConfiguration0()
        case .large:
            self.layoutConfiguration1()
        case .list:
            self.layoutConfiguration2()
        case .ranked:
            self.layoutConfiguration3()
        case .none:
            self.layoutConfiguration0()
        }
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        switch self.properties?.configuration {
        case .standard:
            self.layoutConfiguration0()
        case .large:
            self.layoutConfiguration1()
        case .list:
            self.layoutConfiguration2()
        case .ranked:
            self.layoutConfiguration3()
        case .none:
            self.layoutConfiguration0()
        }
    }
    
    private func layoutConfiguration0() {
        self.imageViewConstraints = [
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: self.properties?.imageAspectRatio ?? 1),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.headlineLabelConstraints = [
            self.headlineLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.headlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
    }
    
    private func layoutConfiguration1() {
        self.headlineLabelConstraints = [
            self.headlineLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.headlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.imageViewConstraints = [
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: self.properties?.imageAspectRatio ?? 1),
            self.imageView.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 10),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.headlineLabel.bottomAnchor, constant: 2),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ]
    }
    
    private func layoutConfiguration2() {
        self.headlineLabelConstraints = [
            self.headlineLabel.widthAnchor.constraint(equalToConstant: 0),
            self.headlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headlineLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ]
        
        self.imageViewConstraints = [
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1 / (self.properties?.imageAspectRatio ?? 1)),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 1),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
        ]
    }
    
    private func layoutConfiguration3() {
        self.headlineLabelConstraints = [
            self.headlineLabel.widthAnchor.constraint(equalToConstant: 20),
            self.headlineLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headlineLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ]
        
        self.imageViewConstraints = [
            self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1 / (self.properties?.imageAspectRatio ?? 1)),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: headlineLabel.trailingAnchor, constant: 10),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.bottomAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: -1),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20),
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.imageView.centerYAnchor, constant: 1),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
        ]
    }
}

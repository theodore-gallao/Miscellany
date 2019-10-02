//
//  HeaderReusableView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/13/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class HeaderCollectionReusableView: BaseCollectionReusableView {
    // Views
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Empty")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    internal let subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    internal let moreArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: UIImage.SymbolWeight.semibold)))
        imageView.tintColor = UIColor(named: "Primary")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // Constraints
    internal var topSeparatorViewConstraints = [NSLayoutConstraint]()
    internal var titleLabelConstraints = [NSLayoutConstraint]()
    internal var subtitleLabelConstraints = [NSLayoutConstraint]()
    internal var moreArrowImageViewConstraints = [NSLayoutConstraint]()
    
    // Initializer
    override func commonInit() {
        super.commonInit()
        
        self.addSubview(self.topSeparatorView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.moreArrowImageView)
        
        self.configureLayout()
    }
    
    // Setter
    public func set(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
}

// MARK: Layout & Constraints
extension HeaderCollectionReusableView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.deactivate(self.topSeparatorViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.subtitleLabelConstraints)
        NSLayoutConstraint.deactivate(self.moreArrowImageViewConstraints)
        
        self.topSeparatorViewConstraints = [
            self.topSeparatorView.heightAnchor.constraint(equalToConstant: 0.75),
            self.topSeparatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.topSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.topSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ]
        
        self.moreArrowImageViewConstraints = [
            self.moreArrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.moreArrowImageView.widthAnchor.constraint(equalTo: self.moreArrowImageView.widthAnchor, constant: 0),
            self.moreArrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 0)
        ]
        
        NSLayoutConstraint.activate(self.topSeparatorViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.subtitleLabelConstraints)
        NSLayoutConstraint.activate(self.moreArrowImageViewConstraints)
    }
}

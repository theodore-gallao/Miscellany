//
//  GroupHeaderReusableView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/20/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

protocol GroupHeaderCollectionReusableViewDelegate {
    func groupHeaderCollectionReusableView(_ groupHeaderCollectionReusableView: GroupHeaderCollectionReusableView, didTap gesture: UITapGestureRecognizer)
}

// MARK: Declaration, Data Members, & Initializers
class GroupHeaderCollectionReusableView: BaseCollectionReusableView {
    var delegate: GroupHeaderCollectionReusableViewDelegate?
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        return tapGestureRecognizer
    }()
    
    // Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = UIColor.label
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Constraints
    internal var titleLabelConstraints = [NSLayoutConstraint]()
    
    // Initializer
    override func commonInit() {
        super.commonInit()
        self.addSubview(self.titleLabel)
        self.addGestureRecognizer(self.tapGestureRecognizer)
        self.isUserInteractionEnabled = true
        
        self.configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // Setter
    public func set(title: String) {
        self.titleLabel.text = title
    }
}

// MARK: Layout & Constraints
extension GroupHeaderCollectionReusableView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(self.titleLabelConstraints)
    }
}

extension GroupHeaderCollectionReusableView {
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.groupHeaderCollectionReusableView(self, didTap: sender)
    }
}

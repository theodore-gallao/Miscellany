//
//  InfoPanelView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct InfoPanelItem {
    var image: UIImage?
    var imageTintColor: UIColor?
    
    var text: String
    var textColor: UIColor?
    var textFont: UIFont?
}

class InfoPanelItemView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.addSubview(self.imageView)
        self.addSubview(self.textLabel)
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        
        self.textLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 2).isActive = true
        self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.6).isActive = true
    }
    
    internal func set(_ item: InfoPanelItem) {
        self.imageView.image = item.image
        self.imageView.tintColor = item.imageTintColor
        
        self.textLabel.text = item.text
        self.textLabel.textColor = item.textColor
        self.textLabel.font = item.textFont
    }
}

class InfoPanelView: UIView {
    private(set) var items = [InfoPanelItem]()
    
    var spacing: CGFloat = 0 {
        didSet {
            self.itemStackView.spacing = self.spacing
        }
    }
    
    private var itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.addSubview(self.itemStackView)
        self.itemStackView.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: 0).isActive = true
        self.itemStackView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 0).isActive = true
        self.itemStackView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: 0).isActive = true
        self.itemStackView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: 0).isActive = true
    }
    
    internal func set(_ items: [InfoPanelItem]) {
        self.items = items
        
        self.itemStackView.safelyRemoveArrangedSubviews()
        
        for item in self.items {
            let infoPanelItemView = InfoPanelItemView()
            infoPanelItemView.set(item)
            
            itemStackView.addArrangedSubview(infoPanelItemView)
        }
    }
}

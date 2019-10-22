//
//  StoryView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryView: BaseView {
    private(set) var story: StoryModel?
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.black)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    var headingLabelConstraints = [NSLayoutConstraint]()
    var imageViewConstraints = [NSLayoutConstraint]()
    var titleLabelConstraints = [NSLayoutConstraint]()
    var authorLabelConstraints = [NSLayoutConstraint]()
    
    func set(_ story: StoryModel, heading: String, imageService: ImageService) {
        self.story = story
        
        self.headingLabel.text = heading
        self.titleLabel.text = story.title
        self.authorLabel.text = story.author.firstName + " " + story.author.lastName
        
        self.imageView.image = UIImage(named: "Story \(story.id)")
        
        self.configureViews()
        self.layoutIfNeeded()
    }
}

// MARK: View, Layout & Constraints
extension StoryView {
    override func configureViews() {
        super.configureViews()
        
        self.addSubview(self.headingLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.authorLabel)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.headingLabelConstraints)
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.headingLabelConstraints)
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.headingLabelConstraints = [
            self.headingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: 10),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: (9 / 6)),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.headingLabelConstraints = [
            self.headingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: 10),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: (9 / 6)),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
    }
}

//
//  StoryCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryCollectionViewCell: BaseCollectionViewCell {
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
    
    let titleLabel: UILabel = {
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
    
    let authorNameLabel: UILabel = {
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
    var titleLabelConstraints = [NSLayoutConstraint]()
    var authorNameLabelConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
        
        self.titleLabel.text = ""
        self.authorNameLabel.text = ""
    }
    
    func set(baseStory: BaseStory, imageService: ImageService = .shared) {
        self.titleLabel.text = baseStory.title
        self.authorNameLabel.text = baseStory.author.firstName + " " + baseStory.author.lastName
        self.imageView.image = UIImage(named: "Story \(baseStory.id)")
        
//        _ = imageService.download(directory: .stories, id: story.id) { [weak self] (result) in
//            switch result {
//            case .success(let image):
//                self?.imageView.image = image
//            case .failure(let error):
//                self?.imageView.image = nil
//                print(error)
//            }
//        }
    }
}

// MARK: View, Layout & Constraints
extension StoryCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.authorNameLabel)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorNameLabelConstraints)
    }
    
    override func configureLayout() {
        super.configureLayout()
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorNameLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 6),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 6),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 6),
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 6),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ]
    }
}



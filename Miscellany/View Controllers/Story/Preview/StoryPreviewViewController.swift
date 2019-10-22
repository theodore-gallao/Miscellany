//
//  StoryPreviewViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryPreviewViewController: BaseViewController {
    // MARK: Data Members
    private let userService: UserService
    private let imageService: ImageService
    
    private(set) var story: StoryModel
    
    // MARK: Views
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        
        return label
    }()
    
    internal let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        
        return label
    }()
    
    private lazy var readButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleTapReadButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Primary")
        button.setTitle("Read This Story", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        button.titleLabel?.textAlignment = .center
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
           
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
           
        return button
    }()
    
    private lazy var readingListButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleTapReadingListButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Background")
        button.tintColor = UIColor(named: "Primary")
        button.adjustsImageWhenHighlighted = false
        button.showsTouchWhenHighlighted = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)), for: UIControl.State.normal)
        button.setTitle("Reading List", for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "Primary"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        button.titleLabel?.textAlignment = .center
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "Primary")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return button
    }()
    
    private lazy var libraryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleTapLibraryButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Background")
        button.tintColor = UIColor(named: "Primary")
        button.adjustsImageWhenHighlighted = false
        button.showsTouchWhenHighlighted = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)), for: UIControl.State.normal)
        button.setTitle("Library", for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "Primary"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        button.titleLabel?.textAlignment = .center
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "Primary")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return button
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 18
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let authorImageBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "Primary")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let infoPanelView: InfoPanelView = {
        let infoPanelView = InfoPanelView()
        infoPanelView.spacing = 32
        infoPanelView.backgroundColor = UIColor.clear
        infoPanelView.translatesAutoresizingMaskIntoConstraints = false
        
        return infoPanelView
    }()
    
    private lazy var awardsView: UIView = {
        let awardsView = AwardsView()
        awardsView.backgroundColor = UIColor(named: "Background")
        awardsView.translatesAutoresizingMaskIntoConstraints = false
        
        return awardsView
    }()
    
    private let descriptionLiteralLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textAlignment = .natural
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    var scrollViewConstraints = [NSLayoutConstraint]()
    var backgroundViewConstraints = [NSLayoutConstraint]()
    var imageViewConstraints = [NSLayoutConstraint]()
    var titleLabelConstraints = [NSLayoutConstraint]()
    var authorLabelConstraints = [NSLayoutConstraint]()
    var infoPanelViewConstraints = [NSLayoutConstraint]()
    var authorImageViewConstraints = [NSLayoutConstraint]()
    var authorImageBorderViewConstraints = [NSLayoutConstraint]()
    var readButtonConstraints = [NSLayoutConstraint]()
    var readingListButtonConstraints = [NSLayoutConstraint]()
    var libraryButtonConstraints = [NSLayoutConstraint]()
    var awardsViewConstraints = [NSLayoutConstraint]()
    var descriptionLiteralLabelConstraints = [NSLayoutConstraint]()
    var descriptionLabelConstraints = [NSLayoutConstraint]()
    
    // MARK: Initializers
    init(story: StoryModel, userService: UserService, imageService: ImageService) {
        self.userService = userService
        self.imageService = imageService
        
        self.story = story
        
        super.init(nibName: nil, bundle: nil)
        
        self.set(story, imageService: imageService)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setter
    func set(_ story: StoryModel, imageService: ImageService) {
        self.story = story
        
        self.imageView.image = UIImage(named: "Story \(story.id)")
        self.authorImageView.image = UIImage(named: "User \(story.author.id)")
        
        self.titleLabel.text = story.title
        self.authorLabel.text = story.author.firstName + " " + story.author.lastName
        
        self.setDescription(story.description)
        self.setInfoPanel(story)
        
        self.configureLayout()
        self.view.layoutIfNeeded()
    }
}

private extension StoryPreviewViewController {
    private func setDescription(_ text: String) {
        let attributedString = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineSpacing = 3
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.descriptionLabel.attributedText = attributedString
    }
    
    private func setInfoPanel(_ story: StoryModel) {
        let isCompact = self.traitCollection.horizontalSizeClass == .compact
        let textSize: CGFloat = isCompact ? 14 : 16
        
        let viewItem = InfoPanelItem(
            image: UIImage(systemName: "eye.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(story.readCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        let ratingItem = InfoPanelItem(
            image: UIImage(systemName: "hand.thumbsup.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: textSize, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(CGFloat(story.likeCount) / CGFloat(max(1, story.dislikeCount)))%",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        let commentsItem = InfoPanelItem(
            image: UIImage(systemName: "bubble.left.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(story.commentCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        
        self.infoPanelView.set([viewItem, ratingItem, commentsItem])
    }
}

// MARK: Properties
extension StoryPreviewViewController {
    override func configureProperties() {
        super.configureProperties()
        
        // Extend layout past navigation and tab bars
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top, .bottom]
    }
}

// MARK: View, Layout & Constraints
extension StoryPreviewViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.backgroundView)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.authorLabel)
        self.scrollView.addSubview(self.infoPanelView)
        self.scrollView.addSubview(self.authorImageView)
        self.scrollView.addSubview(self.authorImageBorderView)
        self.scrollView.addSubview(self.readButton)
        self.scrollView.addSubview(self.readingListButton)
        self.scrollView.addSubview(self.libraryButton)
        self.scrollView.addSubview(self.awardsView)
        self.scrollView.addSubview(self.descriptionLiteralLabel)
        self.scrollView.addSubview(self.descriptionLabel)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.scrollViewConstraints)
        NSLayoutConstraint.deactivate(self.backgroundViewConstraints)
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorLabelConstraints)
        NSLayoutConstraint.deactivate(self.infoPanelViewConstraints)
        NSLayoutConstraint.deactivate(self.authorImageViewConstraints)
        NSLayoutConstraint.deactivate(self.authorImageBorderViewConstraints)
        NSLayoutConstraint.deactivate(self.readButtonConstraints)
        NSLayoutConstraint.deactivate(self.readingListButtonConstraints)
        NSLayoutConstraint.deactivate(self.libraryButtonConstraints)
        NSLayoutConstraint.deactivate(self.awardsViewConstraints)
        NSLayoutConstraint.deactivate(self.descriptionLiteralLabelConstraints)
        NSLayoutConstraint.deactivate(self.descriptionLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.scrollViewConstraints)
        NSLayoutConstraint.activate(self.backgroundViewConstraints)
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorLabelConstraints)
        NSLayoutConstraint.activate(self.infoPanelViewConstraints)
        NSLayoutConstraint.activate(self.authorImageViewConstraints)
        NSLayoutConstraint.activate(self.authorImageBorderViewConstraints)
        NSLayoutConstraint.activate(self.readButtonConstraints)
        NSLayoutConstraint.activate(self.readingListButtonConstraints)
        NSLayoutConstraint.activate(self.libraryButtonConstraints)
        NSLayoutConstraint.activate(self.awardsViewConstraints)
        NSLayoutConstraint.activate(self.descriptionLiteralLabelConstraints)
        NSLayoutConstraint.activate(self.descriptionLabelConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        self.backgroundViewConstraints = [
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ]
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.imageView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 6)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor.constraint(equalToConstant: 20),
            self.infoPanelView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 20),
            self.infoPanelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ]
        
        self.authorImageViewConstraints = [
            self.authorImageView.heightAnchor.constraint(equalToConstant: 36),
            self.authorImageView.widthAnchor.constraint(equalToConstant: 36),
            self.authorImageView.centerYAnchor.constraint(equalTo: self.authorImageBorderView.centerYAnchor),
            self.authorImageView.centerXAnchor.constraint(equalTo: self.authorImageBorderView.centerXAnchor)
        ]
        
        self.authorImageBorderViewConstraints = [
            self.authorImageBorderView.heightAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.widthAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.authorImageBorderView.centerYAnchor.constraint(equalTo: self.readButton.centerYAnchor)
        ]
        
        self.readButtonConstraints = [
            self.readButton.heightAnchor.constraint(equalToConstant: 44),
            self.readButton.topAnchor.constraint(equalTo: self.infoPanelView.bottomAnchor, constant: 20),
            self.readButton.leadingAnchor.constraint(equalTo: self.authorImageBorderView.trailingAnchor, constant: 10),
            self.readButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
        ]
        
        self.readingListButtonConstraints = [
            self.readingListButton.heightAnchor.constraint(equalToConstant: 44),
            self.readingListButton.widthAnchor.constraint(equalTo: self.readButton.widthAnchor, multiplier: 2 / 3),
            self.readingListButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.readingListButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
        ]
        
        self.libraryButtonConstraints = [
            self.libraryButton.heightAnchor.constraint(equalToConstant: 44),
            self.libraryButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.libraryButton.leadingAnchor.constraint(equalTo: self.readingListButton.trailingAnchor, constant: 10),
            self.libraryButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.awardsViewConstraints = [
            self.awardsView.heightAnchor.constraint(equalToConstant: self.story.awards?.isEmpty ?? true ? 0.75 : 44),
            self.awardsView.topAnchor.constraint(equalTo: self.libraryButton.bottomAnchor, constant: 20),
            self.awardsView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.awardsView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.descriptionLiteralLabelConstraints = [
            self.descriptionLiteralLabel.topAnchor.constraint(equalTo: self.awardsView.bottomAnchor, constant: self.story.awards?.isEmpty ?? true ? 0 : 20),
            self.descriptionLiteralLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.descriptionLiteralLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.descriptionLiteralLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -32)
        ]
    }
    
    override func configureViewsForCompactSizeClass() {
        super.configureViewsForCompactSizeClass()
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        self.titleLabel.textAlignment = .center
        
        self.authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.authorLabel.textAlignment = .center
        
        self.descriptionLiteralLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         
        self.readButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        self.readingListButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        self.libraryButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        self.backgroundViewConstraints = [
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ]
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.imageView.widthAnchor.constraint(equalTo: self.view.readableContentGuide.widthAnchor, multiplier: 0.4),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 6)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor.constraint(equalToConstant: 20),
            self.infoPanelView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 20),
            self.infoPanelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ]
        
        self.authorImageViewConstraints = [
            self.authorImageView.heightAnchor.constraint(equalToConstant: 36),
            self.authorImageView.widthAnchor.constraint(equalToConstant: 36),
            self.authorImageView.centerYAnchor.constraint(equalTo: self.authorImageBorderView.centerYAnchor),
            self.authorImageView.centerXAnchor.constraint(equalTo: self.authorImageBorderView.centerXAnchor)
        ]
        
        self.authorImageBorderViewConstraints = [
            self.authorImageBorderView.heightAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.widthAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.authorImageBorderView.centerYAnchor.constraint(equalTo: self.readButton.centerYAnchor)
        ]
        
        self.readButtonConstraints = [
            self.readButton.heightAnchor.constraint(equalToConstant: 44),
            self.readButton.topAnchor.constraint(equalTo: self.infoPanelView.bottomAnchor, constant: 20),
            self.readButton.leadingAnchor.constraint(equalTo: self.authorImageBorderView.trailingAnchor, constant: 10),
            self.readButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
        ]
        
        self.readingListButtonConstraints = [
            self.readingListButton.heightAnchor.constraint(equalToConstant: 44),
            self.readingListButton.widthAnchor.constraint(equalTo: self.readButton.widthAnchor, multiplier: 2 / 3),
            self.readingListButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.readingListButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
        ]
        
        self.libraryButtonConstraints = [
            self.libraryButton.heightAnchor.constraint(equalToConstant: 44),
            self.libraryButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.libraryButton.leadingAnchor.constraint(equalTo: self.readingListButton.trailingAnchor, constant: 10),
            self.libraryButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.awardsViewConstraints = [
            self.awardsView.heightAnchor.constraint(equalToConstant: self.story.awards?.isEmpty ?? true ? 0.75 : 44),
            self.awardsView.topAnchor.constraint(equalTo: self.libraryButton.bottomAnchor, constant: 20),
            self.awardsView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.awardsView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.descriptionLiteralLabelConstraints = [
            self.descriptionLiteralLabel.topAnchor.constraint(equalTo: self.awardsView.bottomAnchor, constant: self.story.awards?.isEmpty ?? true ? 0 : 20),
            self.descriptionLiteralLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.descriptionLiteralLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.descriptionLiteralLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -32)
        ]
    }
}

// MARK: Selectors
extension StoryPreviewViewController {
    @objc private func handleTapReadButton(_ sender: UIButton) {
        let storyViewController = StoryViewController(storyModel: self.story, textSettings: SettingsManager.shared.textSettings, userService: self.userService, storyService: .shared)
        storyViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(storyViewController, animated: true)
    }
    
    @objc private func handleTapReadingListButton(_ sender: UIButton) {
        if let currentUser = self.userService.currentUser, !currentUser.isAnonymous {
            print(currentUser.uid)
        } else {
            self.userService.presentSignIn(in: self)
        }
    }
    
    @objc private func handleTapLibraryButton(_ sender: UIButton) {
        if let currentUser = self.userService.currentUser, !currentUser.isAnonymous {
            print(currentUser.uid)
        } else {
            self.userService.presentSignIn(in: self)
        }
    }
}

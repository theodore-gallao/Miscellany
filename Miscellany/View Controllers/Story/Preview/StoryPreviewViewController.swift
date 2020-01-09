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
    private let storyService: StoryService
    private let userService: UserService
    private let imageService: ImageService
    
    private(set) var story: Story?
    
    // MARK: Views
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
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
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        
        return label
    }()
    
    internal let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .center
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        button.titleLabel?.textAlignment = .center
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
           
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
           
        return button
    }()
    
    private lazy var addToButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleTapReadingListButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Primary")
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        button.showsTouchWhenHighlighted = false
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)), for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return button
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleTapLibraryButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Primary")
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        button.showsTouchWhenHighlighted = false
        button.setImage(UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)), for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return button
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let infoPanelView: InfoPanelView = {
        let infoPanelView = InfoPanelView()
        infoPanelView.spacing = 44
        infoPanelView.backgroundColor = UIColor.clear
        infoPanelView.translatesAutoresizingMaskIntoConstraints = false
        
        return infoPanelView
    }()
    
    private lazy var awardsView: UIView = {
        let awardsView = AwardsView()
        awardsView.backgroundColor = .clear
        awardsView.translatesAutoresizingMaskIntoConstraints = false
        
        return awardsView
    }()
    
    let descriptionLiteralLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textAlignment = .natural
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    var scrollViewConstraints = [NSLayoutConstraint]()
    var imageViewConstraints = [NSLayoutConstraint]()
    var titleLabelConstraints = [NSLayoutConstraint]()
    var authorLabelConstraints = [NSLayoutConstraint]()
    var infoPanelViewConstraints = [NSLayoutConstraint]()
    var authorImageViewConstraints = [NSLayoutConstraint]()
    var readButtonConstraints = [NSLayoutConstraint]()
    var addToButtonConstraints = [NSLayoutConstraint]()
    var moreButtonConstraints = [NSLayoutConstraint]()
    var awardsViewConstraints = [NSLayoutConstraint]()
    var descriptionLiteralLabelConstraints = [NSLayoutConstraint]()
    var descriptionLabelConstraints = [NSLayoutConstraint]()
    
    // MARK: Initializers
    init(storyService: StoryService = .shared, userService: UserService = .shared, imageService: ImageService = .shared) {
        self.storyService = storyService
        self.userService = userService
        self.imageService = imageService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setter
    func set(_ baseStory: BaseStory) {
        let story = Story(id: baseStory.id, dateCreated: Date(), dateUpdated: Date(), title: baseStory.title, description: "", author: baseStory.author, genre: Genre(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "", description: "", storyCount: Int(arc4random_uniform(20))), tags: nil, text: "", readCount: Int(arc4random_uniform(100_000)), likeCount: Int(arc4random_uniform(10_000)), dislikeCount: Int(arc4random_uniform(500)), commentCount: Int(arc4random_uniform(500)), comments: nil, awards: nil, rank: nil)
        
        self.story = story
        
        self.imageView.image = UIImage(named: "Story \(story.id)")
        self.authorImageView.image = UIImage(named: "User \(story.author.id)")
        
        self.titleLabel.text = story.title
        self.authorLabel.text = story.author.firstName + " " + story.author.lastName
        
        self.setDescription(story.description)
        self.setInfoPanel(story)
        
        self.configureLayout()
        self.view.layoutIfNeeded()
        
        self.load()
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
    
    private func setInfoPanel(_ story: Story) {
        let textSize: CGFloat = 16
        
        let viewItem = InfoPanelItem(
            image: UIImage(systemName: "eye.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: textSize, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(story.readCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        
        let likeFloat = CGFloat(story.likeCount)
        let dislikeFloat = CGFloat(story.dislikeCount)
        let likeDislikeRatio = (likeFloat / (likeFloat + dislikeFloat)) * 100
        
        let ratingItem = InfoPanelItem(
            image: UIImage(systemName: "hand.thumbsup.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: textSize, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: String(format: "%.1f", likeDislikeRatio) + "%",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        let commentsItem = InfoPanelItem(
            image: UIImage(systemName: "bubble.left.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: textSize, weight: UIImage.SymbolWeight.regular)),
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
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.authorLabel)
        self.scrollView.addSubview(self.infoPanelView)
        self.scrollView.addSubview(self.authorImageView)
        self.scrollView.addSubview(self.readButton)
        self.scrollView.addSubview(self.addToButton)
        self.scrollView.addSubview(self.moreButton)
        self.scrollView.addSubview(self.awardsView)
        self.scrollView.addSubview(self.descriptionLiteralLabel)
        self.scrollView.addSubview(self.descriptionLabel)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.configureLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        self.scrollView.contentInset = UIEdgeInsets(top: 44 + 20, left: 0, bottom: 20, right: 0)
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.scrollViewConstraints)
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorLabelConstraints)
        NSLayoutConstraint.deactivate(self.infoPanelViewConstraints)
        NSLayoutConstraint.deactivate(self.authorImageViewConstraints)
        NSLayoutConstraint.deactivate(self.readButtonConstraints)
        NSLayoutConstraint.deactivate(self.addToButtonConstraints)
        NSLayoutConstraint.deactivate(self.moreButtonConstraints)
        NSLayoutConstraint.deactivate(self.awardsViewConstraints)
        NSLayoutConstraint.deactivate(self.descriptionLiteralLabelConstraints)
        NSLayoutConstraint.deactivate(self.descriptionLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.scrollViewConstraints)
        NSLayoutConstraint.activate(self.imageViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorLabelConstraints)
        NSLayoutConstraint.activate(self.infoPanelViewConstraints)
        NSLayoutConstraint.activate(self.authorImageViewConstraints)
        NSLayoutConstraint.activate(self.readButtonConstraints)
        NSLayoutConstraint.activate(self.addToButtonConstraints)
        NSLayoutConstraint.activate(self.moreButtonConstraints)
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
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.imageView.widthAnchor.constraint(equalTo: self.view.readableContentGuide.widthAnchor, multiplier: 0.6),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 6)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.authorImageViewConstraints = [
            self.authorImageView.heightAnchor.constraint(equalToConstant: 44),
            self.authorImageView.widthAnchor.constraint(equalToConstant: 44),
            self.authorImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.authorImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.readableContentGuide.leadingAnchor),
            self.authorImageView.trailingAnchor.constraint(equalTo: self.authorLabel.leadingAnchor, constant: -5)
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.centerYAnchor.constraint(equalTo: self.authorImageView.centerYAnchor),
            self.authorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 25 + 2.5),
            self.authorLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor.constraint(equalToConstant: 20),
            self.infoPanelView.topAnchor.constraint(equalTo: self.authorImageView.bottomAnchor, constant: 20),
            self.infoPanelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ]
        
        self.readButtonConstraints = [
            self.readButton.heightAnchor.constraint(equalToConstant: 44),
            self.readButton.topAnchor.constraint(equalTo: self.infoPanelView.bottomAnchor, constant: 20),
            self.readButton.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
        ]
        
        self.addToButtonConstraints = [
            self.addToButton.heightAnchor.constraint(equalToConstant: 44),
            self.addToButton.widthAnchor.constraint(equalToConstant: 44),
            self.addToButton.topAnchor.constraint(equalTo: self.readButton.topAnchor),
            self.addToButton.leadingAnchor.constraint(equalTo: self.readButton.trailingAnchor, constant: 10),
        ]
        
        self.moreButtonConstraints = [
            self.moreButton.heightAnchor.constraint(equalToConstant: 44),
            self.moreButton.widthAnchor.constraint(equalToConstant: 44),
            self.moreButton.topAnchor.constraint(equalTo: self.readButton.topAnchor),
            self.moreButton.leadingAnchor.constraint(equalTo: self.addToButton.trailingAnchor, constant: 10),
            self.moreButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.awardsViewConstraints = [
            self.awardsView.heightAnchor.constraint(equalToConstant: self.story?.awards?.isEmpty ?? true ? 0.75 : 44),
            self.awardsView.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 20),
            self.awardsView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.awardsView.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.descriptionLiteralLabelConstraints = [
            self.descriptionLiteralLabel.topAnchor.constraint(equalTo: self.awardsView.bottomAnchor, constant: self.story?.awards?.isEmpty ?? true ? 0 : 20),
            self.descriptionLiteralLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.descriptionLiteralLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.descriptionLiteralLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -32)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        self.imageViewConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1 / 3),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 9 / 6)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.authorImageViewConstraints = [
            self.authorImageView.heightAnchor.constraint(equalToConstant: 44),
            self.authorImageView.widthAnchor.constraint(equalToConstant: 44),
            self.authorImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.authorImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.readableContentGuide.leadingAnchor),
            self.authorImageView.trailingAnchor.constraint(equalTo: self.authorLabel.leadingAnchor, constant: -5)
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.centerYAnchor.constraint(equalTo: self.authorImageView.centerYAnchor),
            self.authorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 25 + 2.5),
            self.authorLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor.constraint(equalToConstant: 20),
            self.infoPanelView.topAnchor.constraint(equalTo: self.authorImageView.bottomAnchor, constant: 20),
            self.infoPanelView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ]
        
        self.readButtonConstraints = [
            self.readButton.heightAnchor.constraint(equalToConstant: 44),
            self.readButton.topAnchor.constraint(equalTo: self.infoPanelView.bottomAnchor, constant: 20),
            self.readButton.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
        ]
        
        self.addToButtonConstraints = [
            self.addToButton.heightAnchor.constraint(equalToConstant: 44),
            self.addToButton.widthAnchor.constraint(equalToConstant: 44),
            self.addToButton.topAnchor.constraint(equalTo: self.readButton.topAnchor),
            self.addToButton.leadingAnchor.constraint(equalTo: self.readButton.trailingAnchor, constant: 10),
        ]
        
        self.moreButtonConstraints = [
            self.moreButton.heightAnchor.constraint(equalToConstant: 44),
            self.moreButton.widthAnchor.constraint(equalToConstant: 44),
            self.moreButton.topAnchor.constraint(equalTo: self.readButton.topAnchor),
            self.moreButton.leadingAnchor.constraint(equalTo: self.addToButton.trailingAnchor, constant: 10),
            self.moreButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.awardsViewConstraints = [
            self.awardsView.heightAnchor.constraint(equalToConstant: self.story?.awards?.isEmpty ?? true ? 0.75 : 44),
            self.awardsView.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 20),
            self.awardsView.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.awardsView.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.descriptionLiteralLabelConstraints = [
            self.descriptionLiteralLabel.topAnchor.constraint(equalTo: self.awardsView.bottomAnchor, constant: self.story?.awards?.isEmpty ?? true ? 0 : 20),
            self.descriptionLiteralLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.descriptionLiteralLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.descriptionLiteralLabel.bottomAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -32)
        ]
    }
}

// MARK: Load
extension StoryPreviewViewController {
    private func load() {
        self.setDescription("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ex nisl, hendrerit at massa quis, fermentum varius ligula. Vestibulum feugiat fermentum dui, scelerisque ultricies libero malesuada a. Sed risus lectus, rhoncus non sem quis, malesuada tempor eros. Aliquam ac turpis imperdiet, dignissim turpis pulvinar, lobortis enim. Suspendisse ut justo quis urna aliquet consequat sit amet sed urna. Duis aliquet eros sit amet tellus dapibus, et viverra tortor mollis. Etiam mattis commodo tortor a malesuada. Sed condimentum in augue eu tincidunt.")
    }
}

// MARK: Selectors
extension StoryPreviewViewController {
    @objc private func handleTapReadButton(_ sender: UIButton) {
        guard let story = self.story else { return }
        
        let baseStory = BaseStory(id: story.id, title: story.title, author: story.author)
        
        let storyViewController = StoryViewController()
        storyViewController.set(baseStory)
        storyViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(storyViewController, animated: true)
    }
    
    @objc private func handleTapReadingListButton(_ sender: UIButton) {
        if self.userService.currentUser.isRegistered {
            print(self.userService.currentUser.id)
        } else {
            self.userService.presentSignIn(in: self, completion: nil)
        }
    }
    
    @objc private func handleTapLibraryButton(_ sender: UIButton) {
        if self.userService.currentUser.isRegistered {
            print(self.userService.currentUser.id)
        } else {
            self.userService.presentSignIn(in: self, completion: nil)
        }
    }
}

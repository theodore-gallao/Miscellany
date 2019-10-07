//
//  StoryPreviewCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

protocol StoryPreviewCollectionViewCellDelegate: class {
    func storyPreviewCollectionViewCell(_ storyPreviewCollectionViewCell: StoryPreviewCollectionViewCell, didTapRead sender: UIButton)
    
    func storyPreviewCollectionViewCell(_ storyPreviewCollectionViewCell: StoryPreviewCollectionViewCell, didTapReadingList sender: UIButton)
    
    func storyPreviewCollectionViewCell(_ storyPreviewCollectionViewCell: StoryPreviewCollectionViewCell, didTapLibrary sender: UIButton)
}

class StoryPreviewCollectionViewCell: RegularStoryCollectionViewCell {
    weak var delegate: StoryPreviewCollectionViewCellDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let scrollBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 17
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
    
    internal var scrollViewConstraints = [NSLayoutConstraint]()
    internal var scrollBackgroundViewConstraints = [NSLayoutConstraint]()
    internal var infoPanelViewConstraints = [NSLayoutConstraint]()
    internal var authorImageViewConstraints = [NSLayoutConstraint]()
    internal var authorImageBorderViewConstraints = [NSLayoutConstraint]()
    internal var readButtonConstraints = [NSLayoutConstraint]()
    internal var readingListButtonConstraints = [NSLayoutConstraint]()
    internal var libraryButtonConstraints = [NSLayoutConstraint]()
    internal var awardsViewConstraints = [NSLayoutConstraint]()
    internal var descriptionLiteralLabelConstraints = [NSLayoutConstraint]()
    internal var descriptionLabelConstraints = [NSLayoutConstraint]()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.scrollView.contentOffset = CGPoint.zero
        
        self.titleLabel.text?.removeAll()
        self.authorLabel.text?.removeAll()
        self.descriptionLabel.text?.removeAll()
        
        self.authorImageView.image = nil
    }
    
    override func set(_ storyModel: StoryModel, imageService: ImageService) {
        super.set(storyModel, imageService: imageService)
        
        self.setDescription(storyModel.description)
        self.setInfoPanel(storyModel)
        
        self.configureLayout()
        self.layoutIfNeeded()
    }
    
    private func setDescription(_ text: String) {
        let sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada."
        let attributedString = NSMutableAttributedString(string: sampleText) // text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineSpacing = 3
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.descriptionLabel.attributedText = attributedString
    }
    
    private func setInfoPanel(_ storyModel: StoryModel) {
        let isCompact = self.traitCollection.horizontalSizeClass == .compact
        let textSize: CGFloat = isCompact ? 14 : 16
        
        let viewItem = InfoPanelItem(
            image: UIImage(systemName: "eye.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(storyModel.viewCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        let ratingItem = InfoPanelItem(
            image: UIImage(systemName: "hand.thumbsup.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: textSize, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(CGFloat(storyModel.likeCount) / CGFloat(max(1, storyModel.dislikeCount)))%",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        let commentsItem = InfoPanelItem(
            image: UIImage(systemName: "bubble.left.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: UIImage.SymbolWeight.regular)),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(storyModel.commentCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: UIFont.systemFont(ofSize: textSize, weight: .regular))
        
        self.infoPanelView.set([viewItem, ratingItem, commentsItem])
    }
}

// MARK: View, Layout & Constraints
extension StoryPreviewCollectionViewCell {
    override func configureViews() {
        super.configureViews()
        
        self.contentView.addSubview(self.scrollView)
        
        self.coverImageView.removeFromSuperview()
        self.titleLabel.removeFromSuperview()
        self.authorLabel.removeFromSuperview()
        
        self.scrollView.addSubview(self.scrollBackgroundView)
        self.scrollView.addSubview(self.coverImageView)
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
    
    // Layout for any size class
    override func configureLayout() {
        super.configureLayout()
        
        if let storyModel = self.storyModel {
            self.setInfoPanel(storyModel)
        }
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        self.scrollBackgroundViewConstraints = [
            self.scrollBackgroundView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 4),
            self.scrollBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.scrollBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.scrollBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ]
        
        self.authorLabelConstraints = [
            self.authorLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        ]
        
        self.authorImageViewConstraints = [
            self.authorImageView.heightAnchor.constraint(equalToConstant: 34),
            self.authorImageView.widthAnchor.constraint(equalToConstant: 34),
            self.authorImageView.centerYAnchor.constraint(equalTo: authorImageBorderView.centerYAnchor),
            self.authorImageView.centerXAnchor.constraint(equalTo: authorImageBorderView.centerXAnchor)
        ]
        
        self.authorImageBorderViewConstraints = [
            self.authorImageBorderView.heightAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.widthAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.authorImageBorderView.centerYAnchor.constraint(equalTo: self.readButton.centerYAnchor)
        ]
        
        self.readingListButtonConstraints = [
            self.readingListButton.heightAnchor.constraint(equalToConstant: 44),
            self.readingListButton.widthAnchor.constraint(equalTo: self.readButton.widthAnchor, multiplier: 2 / 3),
            self.readingListButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.readingListButton.leadingAnchor.constraint(equalTo: self.authorImageBorderView.leadingAnchor)
        ]
        
        self.libraryButtonConstraints = [
            self.libraryButton.heightAnchor.constraint(equalToConstant: 44),
            self.libraryButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.libraryButton.leadingAnchor.constraint(equalTo: self.readingListButton.trailingAnchor, constant: 10),
            self.libraryButton.trailingAnchor.constraint(equalTo: self.readButton.trailingAnchor)
        ]
        
        self.awardsViewConstraints = [
            self.awardsView.heightAnchor.constraint(equalToConstant: self.storyModel?.awards?.isEmpty ?? true ? 0.75 : 44),
            self.awardsView.topAnchor.constraint(equalTo: self.libraryButton.bottomAnchor, constant: 20),
            self.awardsView.leadingAnchor.constraint(equalTo: self.readingListButton.leadingAnchor),
            self.awardsView.trailingAnchor.constraint(equalTo: self.libraryButton.trailingAnchor)
        ]
        
        self.descriptionLiteralLabelConstraints = [
            self.descriptionLiteralLabel.topAnchor.constraint(equalTo: self.awardsView.bottomAnchor, constant: self.storyModel?.awards?.isEmpty ?? true ? 0 : 20),
            self.descriptionLiteralLabel.leadingAnchor.constraint(equalTo: self.authorImageBorderView.leadingAnchor),
            self.descriptionLiteralLabel.trailingAnchor.constraint(equalTo: self.readButton.trailingAnchor),
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: self.descriptionLiteralLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.descriptionLiteralLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.descriptionLiteralLabel.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -32)
        ]
    }
    
    // Layout for compact size class
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        self.titleLabel.textAlignment = .center
        
        self.authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.authorLabel.textAlignment = .center
        
        self.descriptionLiteralLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        self.coverImageViewConstraints = [
            self.coverImageView.topAnchor.constraint(equalTo: self.scrollBackgroundView.topAnchor, constant: 24),
            self.coverImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6),
            self.coverImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0),
            self.coverImageView.heightAnchor.constraint(equalTo: self.coverImageView.widthAnchor, multiplier: (9 / 6))
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.coverImageView.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor.constraint(equalToConstant: 20),
            self.infoPanelView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 20),
            self.infoPanelView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0),
        ]
        
        self.readButtonConstraints = [
            self.readButton.heightAnchor.constraint(equalToConstant: 44),
            self.readButton.topAnchor.constraint(equalTo: self.infoPanelView.bottomAnchor, constant: 20),
            self.readButton.leadingAnchor.constraint(equalTo: self.authorImageBorderView.trailingAnchor, constant: 10),
            self.readButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 0),
        ]
    }
    
    // Layout for regular size class
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        self.titleLabel.textAlignment = .natural
        
        self.authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.authorLabel.textAlignment = .natural
        
        self.descriptionLiteralLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        self.coverImageViewConstraints = [
            self.coverImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 44),
            self.coverImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1 / 3),
            self.coverImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 44),
            self.coverImageView.heightAnchor.constraint(equalTo: self.coverImageView.widthAnchor, multiplier: (9 / 6))
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.coverImageView.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.coverImageView.trailingAnchor, constant: 32),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -44),
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor.constraint(equalToConstant: 22),
            self.infoPanelView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 16),
            self.infoPanelView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: 0),
            self.infoPanelView.trailingAnchor.constraint(lessThanOrEqualTo: self.titleLabel.trailingAnchor, constant: 0)
        ]
        
        self.authorImageBorderViewConstraints = [
            self.authorImageBorderView.heightAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.widthAnchor.constraint(equalToConstant: 44),
            self.authorImageBorderView.leadingAnchor.constraint(equalTo: self.coverImageView.trailingAnchor, constant: 32),
            self.authorImageBorderView.centerYAnchor.constraint(equalTo: self.readButton.centerYAnchor)
        ]
        
        self.readButtonConstraints = [
            self.readButton.heightAnchor.constraint(equalToConstant: 44),
            self.readButton.leadingAnchor.constraint(equalTo: self.authorImageBorderView.trailingAnchor, constant: 10),
            self.readButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 0)
        ]
        
        self.libraryButtonConstraints = [
            self.libraryButton.heightAnchor.constraint(equalToConstant: 44),
            self.libraryButton.topAnchor.constraint(equalTo: self.readButton.bottomAnchor, constant: 10),
            self.libraryButton.leadingAnchor.constraint(equalTo: self.readingListButton.trailingAnchor, constant: 10),
            self.libraryButton.trailingAnchor.constraint(equalTo: self.readButton.trailingAnchor),
            self.libraryButton.bottomAnchor.constraint(equalTo: self.coverImageView.bottomAnchor)
        ]
        
        self.descriptionLiteralLabelConstraints = [
            self.descriptionLiteralLabel.topAnchor.constraint(equalTo: self.awardsView.bottomAnchor, constant: self.storyModel?.awards?.isEmpty ?? true ? 0 : 20),
            self.descriptionLiteralLabel.leadingAnchor.constraint(equalTo: self.coverImageView.leadingAnchor, constant: 0),
            self.descriptionLiteralLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 0),
        ]
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.scrollViewConstraints)
        NSLayoutConstraint.deactivate(self.scrollBackgroundViewConstraints)
        NSLayoutConstraint.deactivate(self.coverImageViewConstraints)
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
        NSLayoutConstraint.activate(self.scrollBackgroundViewConstraints)
        NSLayoutConstraint.activate(self.coverImageViewConstraints)
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
}

// MARK: Selectors
extension StoryPreviewCollectionViewCell {
    @objc private func handleTapReadButton(_ sender: UIButton) {
        self.delegate?.storyPreviewCollectionViewCell(self, didTapRead: sender)
    }
    
    @objc private func handleTapReadingListButton(_ sender: UIButton) {
        self.delegate?.storyPreviewCollectionViewCell(self, didTapReadingList: sender)
    }
    
    @objc private func handleTapLibraryButton(_ sender: UIButton) {
        self.delegate?.storyPreviewCollectionViewCell(self, didTapLibrary: sender)
    }
}

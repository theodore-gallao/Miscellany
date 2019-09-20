//
//  StoryViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryViewController: UIViewController {
    
    // MARK: Data Members
    let storyModel: StoryModel
    
    let textSettings: TextSettings
    
    // MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor(named: "Background")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 8
        
        imageView.setContentCompressionResistancePriority(
            UILayoutPriority.defaultLow,
            for: NSLayoutConstraint.Axis.vertical)
        imageView.setContentHuggingPriority(
            UILayoutPriority.defaultLow,
            for: NSLayoutConstraint.Axis.vertical)
        
        return imageView
    }()
    
    private let coverImageBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "Empty")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.setContentCompressionResistancePriority(
            UILayoutPriority.defaultLow,
            for: NSLayoutConstraint.Axis.vertical)
        imageView.setContentHuggingPriority(
            UILayoutPriority.defaultLow,
            for: NSLayoutConstraint.Axis.vertical)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(blurEffectView)
        
        blurEffectView.topAnchor.constraint(
            equalTo: imageView.topAnchor,
            constant: 0).isActive = true
        blurEffectView.leadingAnchor.constraint(
            equalTo: imageView.leadingAnchor,
            constant: 0).isActive = true
        blurEffectView.trailingAnchor.constraint(
            equalTo: imageView.trailingAnchor,
            constant: 0).isActive = true
        blurEffectView.bottomAnchor.constraint(
            equalTo: imageView.bottomAnchor,
            constant: 0).isActive = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Author Image")
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let authorImageBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "Primary")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Primary")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(
            UILayoutPriority.required,
            for: NSLayoutConstraint.Axis.vertical)
        label.setContentHuggingPriority(
            UILayoutPriority.required,
            for: NSLayoutConstraint.Axis.vertical)
        label.setContentCompressionResistancePriority(
            UILayoutPriority.required,
            for: NSLayoutConstraint.Axis.horizontal)
        label.setContentHuggingPriority(
            UILayoutPriority.required,
            for: NSLayoutConstraint.Axis.horizontal)
        
        return label
    }()
    
    private let infoPanelView: InfoPanelView = {
        let infoPanelView = InfoPanelView()
        infoPanelView.spacing = 24
        infoPanelView.backgroundColor = UIColor.clear
        infoPanelView.translatesAutoresizingMaskIntoConstraints = false
        
        return infoPanelView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Subtext")
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.font = UIFont.systemFont(
            ofSize: 18,
            weight: UIFont.Weight.regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        label.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        
        return label
    }()
    
    private lazy var authorBarButtonItem: UIBarButtonItem = {
        let size = CGSize(
            width: 32,
            height: 32)
        let borderColor = UIColor(named: "Primary") ?? UIColor.clear
        let image = UIImage(named: "Author Image") // TODO: Change to URL image
        let circularImage = image?.circularImage(
            size: size,
            borderColor: borderColor)
        let originalCircularImage = circularImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let barButtonItem = UIBarButtonItem(
            image: originalCircularImage,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleAuthorBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    private lazy var textBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "Text"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleTextBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    private lazy var voteBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "Star"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleVoteBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    private lazy var commentBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "Comment"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleCommentBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    private lazy var shareBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "Share"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleShareBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    private lazy var moreBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "More"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleMoreBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    // MARK: Initializers
    init(storyModel: StoryModel, textSettings: TextSettings) {
        self.storyModel = storyModel
        self.textSettings = textSettings
        
        super.init(nibName: nil, bundle: nil)
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setDescriptionLabel(self.storyModel.description)
        self.setTextLabel(self.storyModel.text)
        self.setInfoPanel(self.storyModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // THIS IS FOR TESTING PURPOSES ONLY. WILL DELETE AT LAUNCH
    internal func set(_ image: UIImage?) {
        self.coverImageView.image = image
        self.coverImageBackgroundView.image = image
    }
    
    // MARK: View Controller States
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top, .bottom]
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.coverImageBackgroundView)
        self.scrollView.addSubview(self.coverImageView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.authorImageView)
        self.scrollView.addSubview(self.authorImageBorderView)
        self.scrollView.addSubview(self.authorNameLabel)
        self.scrollView.addSubview(self.infoPanelView)
        self.scrollView.addSubview(self.descriptionLabel)
        self.scrollView.addSubview(self.textLabel)
        
        self.configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation(animated)
    }
    
    
    // MARK: Layout & Constraints
    private var scrollViewConstraints = [NSLayoutConstraint]()
    private var coverImageViewConstraints = [NSLayoutConstraint]()
    private var coverImageBackgroundViewConstraints = [NSLayoutConstraint]()
    private var titleLabelConstraints = [NSLayoutConstraint]()
    private var authorImageViewConstraints = [NSLayoutConstraint]()
    private var authorImageBorderViewConstraints = [NSLayoutConstraint]()
    private var authorNameLabelConstraints = [NSLayoutConstraint]()
    private var infoPanelViewConstraints = [NSLayoutConstraint]()
    private var descriptionLabelConstraints = [NSLayoutConstraint]()
    private var textLabelConstraints = [NSLayoutConstraint]()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    private func configureLayout() {
        NSLayoutConstraint.deactivate(self.scrollViewConstraints)
        NSLayoutConstraint.deactivate(self.coverImageViewConstraints)
        NSLayoutConstraint.deactivate(self.coverImageBackgroundViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorImageViewConstraints)
        NSLayoutConstraint.deactivate(self.authorImageBorderViewConstraints)
        NSLayoutConstraint.deactivate(self.authorNameLabelConstraints)
        NSLayoutConstraint.deactivate(self.infoPanelViewConstraints)
        NSLayoutConstraint.deactivate(self.descriptionLabelConstraints)
        NSLayoutConstraint.deactivate(self.textLabelConstraints)
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.scrollView.leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        
        self.coverImageViewConstraints = [
            self.coverImageView.topAnchor
                .constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.coverImageView.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.coverImageView.widthAnchor
                .constraint(equalTo: self.view.widthAnchor, multiplier: 6 / 9),
            self.coverImageView.heightAnchor
                .constraint(equalTo: self.coverImageView.widthAnchor, multiplier: 9 / 6)
        ]
        
        self.coverImageBackgroundViewConstraints = [
            self.coverImageBackgroundView.topAnchor
                .constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            self.coverImageBackgroundView.leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.coverImageBackgroundView.trailingAnchor
                .constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.coverImageBackgroundView.bottomAnchor
                .constraint(equalTo: self.coverImageView.bottomAnchor, constant: -44 - 20)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor
                .constraint(equalTo: self.coverImageView.bottomAnchor, constant: 16),
            self.titleLabel.leadingAnchor
                .constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor
                .constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0)
        ]
        
        self.authorImageViewConstraints = [
            self.authorImageView.heightAnchor.constraint(
                equalToConstant: 40),
            self.authorImageView.widthAnchor.constraint(
                equalToConstant: 40),
            self.authorImageView.topAnchor.constraint(
                equalTo: self.titleLabel.bottomAnchor,
                constant: 16),
        ]
        
        self.authorImageBorderViewConstraints = [
            self.authorImageBorderView.heightAnchor.constraint(
                equalTo: authorImageView.heightAnchor,
                constant: 9),
            self.authorImageBorderView.widthAnchor.constraint(
                equalTo: authorImageView.widthAnchor,
                constant: 9),
            self.authorImageBorderView.centerYAnchor.constraint(
                equalTo: authorImageView.centerYAnchor,
                constant: 0),
            self.authorImageBorderView.centerXAnchor.constraint(
                equalTo: authorImageView.centerXAnchor,
                constant: 0),
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.leadingAnchor.constraint(
                equalTo: self.authorImageView.trailingAnchor,
                constant: 16),
            self.authorNameLabel.centerYAnchor.constraint(
                equalTo: self.authorImageView.centerYAnchor,
                constant: 0),
            self.authorNameLabel.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor,
                constant: 22)
        ]
        
        self.infoPanelViewConstraints = [
            self.infoPanelView.heightAnchor
                .constraint(equalToConstant: 20),
            self.infoPanelView.topAnchor
            .constraint(equalTo: self.authorImageView.bottomAnchor, constant: 16),
            self.infoPanelView.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor, constant: 0),
        ]
        
        self.descriptionLabelConstraints = [
            self.descriptionLabel.topAnchor
                .constraint(equalTo: self.infoPanelView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor
                .constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.descriptionLabel.trailingAnchor
                .constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0)
        ]
        
        self.textLabelConstraints = [
            self.textLabel.topAnchor
                .constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.textLabel.leadingAnchor
                .constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.textLabel.trailingAnchor
                .constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0),
            self.textLabel.bottomAnchor
                .constraint(equalTo: self.scrollView.bottomAnchor, constant: -100)
        ]
        
        NSLayoutConstraint.activate(self.scrollViewConstraints)
        NSLayoutConstraint.activate(self.coverImageViewConstraints)
        NSLayoutConstraint.activate(self.coverImageBackgroundViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorImageViewConstraints)
        NSLayoutConstraint.activate(self.authorImageBorderViewConstraints)
        NSLayoutConstraint.activate(self.authorNameLabelConstraints)
        NSLayoutConstraint.activate(self.infoPanelViewConstraints)
        NSLayoutConstraint.activate(self.descriptionLabelConstraints)
        NSLayoutConstraint.activate(self.textLabelConstraints)
    }
    
    // MARK: Navigation & Bars
    internal func configureNavigation(_ animated: Bool) {
        self.configureNavigationBar(animated)
        self.configureNavigationBarAppearance(animated)
        
        self.configureToolbarAppearance(animated)
        self.configureToolbar(animated)
    }
    
    internal func configureNavigationBar(_ animated: Bool) {
        self.navigationItem.title = ""
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.setRightBarButtonItems(
            [self.textBarButtonItem],
            animated: animated)
    }
    
    internal func configureToolbar(_ animated: Bool) {
        let spacer1 = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let spacer2 = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let spacer3 = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        
        self.setToolbarItems(
            [
                self.voteBarButtonItem,
                spacer1,
                self.commentBarButtonItem,
                spacer2,
                self.shareBarButtonItem,
                spacer3,
                self.moreBarButtonItem],
            animated: animated)
    }
    
    internal func configureNavigationBarAppearance(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(
                false,
                animated: animated)
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = true
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            navigationController.navigationBar.barTintColor = UIColor(named: "Background")
            navigationController.navigationBar.barStyle = .default
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(
                    ofSize: 18,
                    weight: UIFont.Weight.black)]
            navigationController.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(
                    ofSize: 34,
                    weight: UIFont.Weight.black)]
        }
    }
    
    internal func configureToolbarAppearance(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.setToolbarHidden(
                false,
                animated: animated)
            navigationController.toolbar.barStyle = .default
            navigationController.toolbar.isTranslucent = false
            navigationController.toolbar.tintColor = UIColor(named: "Primary")
            navigationController.toolbar.barTintColor = UIColor(named: "Background")
            navigationController.toolbar.setShadowImage(
                UIImage(),
                forToolbarPosition: UIBarPosition.any)
        }
    }
}

// MARK: Private Helper Functions
private extension StoryViewController {
    private func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
        
        if self.textSettings.textFontType == .default {
            self.titleLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.black)
        } else {
            let textSize: CGFloat = 36
            let textFont = self.textSettings.textFont.withSize(textSize).bold
            
            self.titleLabel.font = textFont
        }
    }
    
    private func setAuthorLabel(_ text: String) {
        self.authorNameLabel.text = text
        
        let textSize: CGFloat = 16
        let textFont = self.textSettings.textFont.withSize(textSize).bold
        
        self.authorNameLabel.font = textFont
    }
    
    private func setDescriptionLabel(_ text: String) {
        let attributedString = NSMutableAttributedString(string: "--------\n\(text)\n--------")

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        if self.textSettings.lineSpacing == .compact {
            paragraphStyle.lineSpacing = 4
        } else if self.textSettings.lineSpacing == .standard {
            paragraphStyle.lineSpacing = 12
        } else {
            paragraphStyle.lineSpacing = 20
        }
        
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.descriptionLabel.font = self.textSettings.textFont.italic.withSize(self.textSettings.textSize)
        self.descriptionLabel.attributedText = attributedString
    }
    
    private func setTextLabel(_ text: String) {
        let attributedString = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        if self.textSettings.lineSpacing == .compact {
            paragraphStyle.lineSpacing = 4
        } else if self.textSettings.lineSpacing == .standard {
            paragraphStyle.lineSpacing = 12
        } else {
            paragraphStyle.lineSpacing = 20
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.textLabel.font = self.textSettings.textFont.withSize(self.textSettings.textSize)
        self.textLabel.attributedText = attributedString
    }
    
    private func setInfoPanel(_ storyModel: StoryModel) {
        let textSize: CGFloat = 14
        let textFont = self.textSettings.textFont.withSize(textSize).bold
        
        let viewItem = InfoPanelItem(
            image: UIImage(named: "View"),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(storyModel.viewCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: textFont)
        let ratingItem = InfoPanelItem(
            image: UIImage(named: "Star"),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(storyModel.rating)",
            textColor: UIColor(named: "Primary"),
            textFont: textFont)
        let commentsItem = InfoPanelItem(
            image: UIImage(named: "Comment"),
            imageTintColor: UIColor(named: "Primary"),
            text: "\(storyModel.commentCount.formatted)",
            textColor: UIColor(named: "Primary"),
            textFont: textFont)
        
        self.infoPanelView.set([viewItem, ratingItem, commentsItem])
    }
}

// MARK: Text Settings View Controller Delegate
extension StoryViewController: TextSettingsViewControllerDelegate {
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextSize to: CGFloat) {
        self.textSettings.textSize = to
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setDescriptionLabel(self.storyModel.description)
        self.setTextLabel(self.storyModel.text)
        self.setInfoPanel(self.storyModel)
    }
    
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextFontType to: TextSettings.FontType) {
        self.textSettings.textFontType = to
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setDescriptionLabel(self.storyModel.description)
        self.setTextLabel(self.storyModel.text)
        self.setInfoPanel(self.storyModel)
    }
    
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeLineSpacing to: TextSettings.LineSpacing) {
        self.textSettings.lineSpacing = to
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setDescriptionLabel(self.storyModel.description)
        self.setTextLabel(self.storyModel.text)
        self.setInfoPanel(self.storyModel)
    }
}

// MARK: View Controller Transitioning Delegate
extension StoryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented is TextSettingsViewController {
            let fractionalHeightPresentationController = FractionalHeightPresentationController(
                presentedViewController: presented,
                presenting: presenting)
            fractionalHeightPresentationController.fractionalHeight = 0.5
            
            return fractionalHeightPresentationController
        } else {
            return nil
        }
    }
}

// MARK: Selectors
extension StoryViewController {
    @objc private func handleAuthorBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func handleTextBarButtonItem(_ sender: UIBarButtonItem) {
        let textSettingsViewController = TextSettingsViewController(textSettings: self.textSettings)
        textSettingsViewController.delegate = self
        
        // When compact, use custom transition to show half
        // Otherwise, use popover transition
        if self.traitCollection.horizontalSizeClass == .compact {
            textSettingsViewController.modalPresentationStyle = .custom
            textSettingsViewController.transitioningDelegate = self
            textSettingsViewController.isModalInPresentation = false
        } else {
            textSettingsViewController.modalPresentationStyle = .popover
            textSettingsViewController.popoverPresentationController?.barButtonItem = sender
        }
        
        self.present(textSettingsViewController, animated: true, completion: nil)
    }
    
    @objc private func handleVoteBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func handleCommentBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func handleShareBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func handleMoreBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
}

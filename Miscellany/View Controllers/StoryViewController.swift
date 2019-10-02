//
//  StoryViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryViewController: BaseViewController {
    // MARK: Data Members & Initializers
    
    // Data
    let storyModel: StoryModel
    let textSettings: TextSettings
    
    // Constraint Variables
    var scrollViewConstraints = [NSLayoutConstraint]()
    var titleLabelConstraints = [NSLayoutConstraint]()
    var authorNameLabelConstraints = [NSLayoutConstraint]()
    var textLabelConstraints = [NSLayoutConstraint]()
    
    // Views
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: "Background")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    lazy var textBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "textformat", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleTextBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var likeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "hand.thumbsup", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleLikeBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var dislikeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "hand.thumbsdown", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleDislikeBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var commentBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.fill", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.regular)),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleCommentBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var shareBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrowshape.turn.up.right.fill", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.regular)),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleShareBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var moreBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)),
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
        self.setTextLabel(self.storyModel.text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: View Controller States
extension StoryViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.view.layoutIfNeeded()
//
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        self.navigationController?.setToolbarHidden(true, animated: animated)
//
//        UIView.animate(withDuration: 1 / 3) {
//            self.view.layoutIfNeeded()
//        }
    }
}

// MARK: Properties
extension StoryViewController {
    override func configureProperties() {
        super.configureProperties()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top, .bottom]
    }
}

// MARK: View, Layout & Constraints
extension StoryViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.authorNameLabel)
        self.scrollView.addSubview(self.textLabel)
        
    }
    override func configureLayout() {
        super.configureLayout()
        
        NSLayoutConstraint.deactivate(self.scrollViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorNameLabelConstraints)
        NSLayoutConstraint.deactivate(self.textLabelConstraints)
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 32),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0)
        ]
        
        self.textLabelConstraints = [
            self.textLabel.topAnchor.constraint(equalTo: self.authorNameLabel.bottomAnchor, constant: 32),
            self.textLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 0),
            self.textLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: 0),
            self.textLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -32)
        ]
        
        NSLayoutConstraint.activate(self.scrollViewConstraints)
        NSLayoutConstraint.activate(self.titleLabelConstraints)
        NSLayoutConstraint.activate(self.authorNameLabelConstraints)
        NSLayoutConstraint.activate(self.textLabelConstraints)
    }
}

// MARK: Navigation & Bars
extension StoryViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.configureNavigationBar(animated)
        self.configureNavigationBarAppearance(animated)
        
        self.configureToolbarAppearance(animated)
        self.configureToolbar(animated)
    }
    
    internal func configureNavigationBar(_ animated: Bool) {
        self.navigationItem.title = ""
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.setRightBarButtonItems(
            [self.textBarButtonItem, self.moreBarButtonItem],
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
        
        self.setToolbarItems([
            self.likeBarButtonItem,
            spacer1,
            self.dislikeBarButtonItem,
            spacer2,
            self.commentBarButtonItem,
            spacer3,
            self.shareBarButtonItem],
            animated: animated)
    }
    
    internal func configureNavigationBarAppearance(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(
                false,
                animated: animated)
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = true
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

// MARK: Private Setters
private extension StoryViewController {
    private func setTitleLabel(_ text: String) {
        self.titleLabel.text = text
        
        let textSize = self.textSettings.textSize + 6
        
        if self.textSettings.textFontType == .default {
            self.titleLabel.font = UIFont.systemFont(
                ofSize: textSize,
                weight: UIFont.Weight.black)
        } else {
            let textFont = self.textSettings.textFont.withSize(textSize).bold
            
            self.titleLabel.font = textFont
        }
    }
    
    private func setAuthorLabel(_ text: String) {
        self.authorNameLabel.text = text
        
        let textFont = self.textSettings.textFont.withSize(self.textSettings.textSize)
        
        self.authorNameLabel.font = textFont
    }
    
    private func setTextLabel(_ text: String) {
        let sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\nEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at."
        let attributedString = NSMutableAttributedString(string: sampleText) // text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
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
}

// MARK: Text Settings View Controller Delegate
extension StoryViewController: TextSettingsViewControllerDelegate {
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextSize to: CGFloat) {
        self.textSettings.textSize = to
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setTextLabel(self.storyModel.text)
    }
    
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextFontType to: TextSettings.FontType) {
        self.textSettings.textFontType = to
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setTextLabel(self.storyModel.text)
    }
    
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeLineSpacing to: TextSettings.LineSpacing) {
        self.textSettings.lineSpacing = to
        
        self.setTitleLabel(self.storyModel.title)
        self.setAuthorLabel(self.storyModel.author.firstName + " " + self.storyModel.author.lastName)
        self.setTextLabel(self.storyModel.text)
    }
}

// MARK: View Controller Transitioning Delegate
extension StoryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController? , source: UIViewController) -> UIPresentationController? {
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
    
    @objc private func handleLikeBarButtonItem(_ sender: UIBarButtonItem) {
        print("tap like")
    }
    
    @objc private func handleDislikeBarButtonItem(_ sender: UIBarButtonItem) {
        print("tap dislike")
    }
    
    @objc private func handleCommentBarButtonItem(_ sender: UIBarButtonItem) {
        print("tap comment")
    }
    
    @objc private func handleShareBarButtonItem(_ sender: UIBarButtonItem) {
        print("tap share")
    }
    
    @objc private func handleMoreBarButtonItem(_ sender: UIBarButtonItem) {
        print("tap more")
    }
}

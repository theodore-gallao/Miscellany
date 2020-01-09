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
    
    // MARK: Services & Managers
    let userService: UserService
    let storyService: StoryService
    let textSettings: TextSettings
    
    // MARK: Data
    private(set) var story: Story?
    
    // MARK: Constraint Variables
    var scrollViewConstraints = [NSLayoutConstraint]()
    var imageViewConstraints = [NSLayoutConstraint]()
    var titleLabelConstraints = [NSLayoutConstraint]()
    var authorNameLabelConstraints = [NSLayoutConstraint]()
    var textLabelConstraints = [NSLayoutConstraint]()
    
    // MARK: Views
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(named: "Subtext")
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var textBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "textformat", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)),
            style: .plain,
            target: self,
            action: #selector(self.handleTextBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var likeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "hand.thumbsup", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)),
            style: .plain,
            target: self,
            action: #selector(self.handleLikeBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var dislikeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "hand.thumbsdown", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)),
            style: .plain,
            target: self,
            action: #selector(self.handleDislikeBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    lazy var commentBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.fill", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.semibold)),
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
            image: UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.semibold)),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.handleMoreBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    // MARK: Initializers
    init(textSettings: TextSettings = .shared,
         userService: UserService = .shared,
         storyService: StoryService = .shared
    ) {
        self.story = nil
        self.textSettings = textSettings
        self.userService = userService
        self.storyService = storyService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setters
    func set(_ baseStory: BaseStory) {
        let story = Story(id: baseStory.id, dateCreated: Date(), dateUpdated: Date(), title: baseStory.title, description: "", author: baseStory.author, genre: Genre(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "", description: "", storyCount: 0), tags: nil, text: "", readCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil, awards: nil, rank: nil)
        self.story = story
        
        self.setTitleLabel(baseStory.title)
        self.setAuthorLabel("\(baseStory.author.firstName) \(baseStory.author.lastName)")
        self.setTextLabel(nil)
        
        self.load()
    }
}

// MARK: Load
extension StoryViewController {
    private func load() {
        self.setTextLabel(nil)
    }
}

// MARK: View Controller States
extension StoryViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 44 + 44),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.textLabelConstraints = [
            self.textLabel.topAnchor.constraint(equalTo: self.authorNameLabel.bottomAnchor, constant: 32),
            self.textLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.textLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.textLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -(44 + 44))
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.scrollViewConstraints = [
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        
        self.titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 44 + 44),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.authorNameLabelConstraints = [
            self.authorNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            self.authorNameLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.authorNameLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor)
        ]
        
        self.textLabelConstraints = [
            self.textLabel.topAnchor.constraint(equalTo: self.authorNameLabel.bottomAnchor, constant: 32),
            self.textLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.textLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.textLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -(44 + 44))
        ]
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.scrollViewConstraints)
        NSLayoutConstraint.deactivate(self.imageViewConstraints)
        NSLayoutConstraint.deactivate(self.titleLabelConstraints)
        NSLayoutConstraint.deactivate(self.authorNameLabelConstraints)
        NSLayoutConstraint.deactivate(self.textLabelConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.scrollViewConstraints)
        NSLayoutConstraint.activate(self.imageViewConstraints)
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
            navigationController.hidesBarsOnSwipe = true
            navigationController.hidesBarsOnTap = true
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            navigationController.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    internal func configureToolbarAppearance(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.toolbar.tintColor = UIColor(named: "Primary")
            navigationController.setToolbarHidden(false, animated: animated)
        }
    }
}

// MARK: Private Setters
private extension StoryViewController {
    private func setTitleLabel(_ text: String?) {
        self.titleLabel.text = text
        
        let textSize = self.textSettings.textSize + 6
        
        let textFont = self.textSettings.textFont.withSize(textSize).bold
        
        self.titleLabel.font = textFont
    }
    
    private func setAuthorLabel(_ text: String?) {
        self.authorNameLabel.text = text
        
        let textFont = self.textSettings.textFont.withSize(self.textSettings.textSize)
        
        self.authorNameLabel.font = textFont
    }
    
    private func setTextLabel(_ text: String?) {
        let attributedString = NSMutableAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at velit nec nunc iaculis blandit in sit amet metus. Ut iaculis, justo non malesuada vulputate, nunc nulla vulputate nisi, eu lobortis nulla justo et leo. Ut ac fringilla sem. Donec volutpat sit amet tortor quis lobortis. Curabitur eleifend metus ac nulla posuere facilisis. Sed in libero non eros ornare pharetra. Phasellus condimentum a sapien scelerisque aliquet. Proin tempus est risus, ac mattis nulla interdum tempor. Duis aliquam lectus vel turpis ullamcorper malesuada. Phasellus sodales, augue ac tempus feugiat, arcu ipsum ultricies risus, nec ultricies leo elit vel eros. Fusce rhoncus nisl quam, nec rutrum felis dignissim ac.\n\nSed auctor quis ipsum non accumsan. Pellentesque quis tortor erat. Quisque fringilla egestas sapien, sed elementum velit tristique in. Mauris nisl dui, aliquet eget dignissim et, hendrerit ac neque. Aliquam id nisi gravida, gravida risus convallis, consequat odio. Vivamus metus dolor, placerat ut sapien vitae, rutrum vehicula nisl. Aenean egestas et tortor volutpat pharetra. Pellentesque lobortis elementum ante, id eleifend lorem imperdiet sed.\n\nDonec luctus blandit quam, at laoreet tellus sodales vel. Mauris ex lectus, facilisis ut ex nec, pretium accumsan ligula. Phasellus et malesuada neque, sit amet efficitur mauris. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque nec turpis vel dui feugiat pharetra. Pellentesque libero lacus, ultrices vel porttitor in, fringilla ac urna. Etiam non ante at augue posuere efficitur eget a urna. In vel magna volutpat, mattis turpis vestibulum, porta sem. Mauris in elit luctus, scelerisque augue vitae, sollicitudin eros. Praesent vestibulum diam quis hendrerit bibendum. Phasellus feugiat velit vitae lobortis consectetur. Fusce condimentum odio quis libero fermentum blandit. Etiam leo orci, suscipit quis laoreet nec, vehicula vitae lectus. Fusce nec dapibus neque. Nulla facilisi.\n\nPhasellus mattis libero vitae nisi aliquam dictum. Nullam tempor finibus neque, laoreet fermentum arcu vulputate quis. Aliquam ut semper lorem. Integer maximus ex sapien, quis lacinia dui imperdiet sit amet. Nam dictum mi arcu, sit amet lobortis nisl dapibus eu. Morbi et augue quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam feugiat dui enim, sit amet pulvinar tortor tincidunt non. Mauris nec ligula tempus, volutpat dolor quis, ultricies mauris. Nam viverra auctor metus. Donec maximus ipsum non metus pretium ullamcorper. Sed eget mauris ornare, pulvinar risus et, facilisis magna. Ut venenatis, justo et tincidunt commodo, nulla metus ultricies neque, at pulvinar purus nulla ac tellus.\n\nIn eu nunc ut quam condimentum cursus. Curabitur ut gravida purus, sed consectetur leo. Aenean ultricies mollis urna nec hendrerit. Sed dignissim vestibulum eros non facilisis. Aenean porttitor libero et metus porta sodales. Nam non erat consectetur, tristique ante quis, cursus lorem. Aenean lobortis odio ut tellus sagittis maximus. Vestibulum eu aliquam lectus. Nam dictum et leo vitae pellentesque. Curabitur egestas nisl sed imperdiet vulputate. Cras dignissim, arcu vitae elementum maximus, nibh orci commodo orci, at suscipit massa mauris vitae ex. Vivamus malesuada sollicitudin fringilla. Maecenas non diam lobortis, bibendum enim sit amet, mollis est. In vitae dapibus enim. Vivamus interdum erat eu mi sagittis, sed faucibus nibh ultrices. Praesent dolor massa, hendrerit tempor sodales eget, semper id dui.")// text ?? "")

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
        
        self.setTitleLabel(self.story?.title)
        self.setAuthorLabel("\(self.story?.author.firstName ?? "") \(self.story?.author.lastName ?? "")")
        self.setTextLabel(self.story?.text)
    }
    
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeTextFontType to: TextSettings.FontType) {
        self.textSettings.textFontType = to
        
        self.setTitleLabel(self.story?.title)
        self.setAuthorLabel("\(self.story?.author.firstName ?? "") \(self.story?.author.lastName ?? "")")
        self.setTextLabel(self.story?.text)
    }
    
    func textSettingsViewController(_ textSettingsViewController: TextSettingsViewController, textSettings: TextSettings, didChangeLineSpacing to: TextSettings.LineSpacing) {
        self.textSettings.lineSpacing = to
        
        self.setTitleLabel(self.story?.title)
        self.setAuthorLabel("\(self.story?.author.firstName ?? "") \(self.story?.author.lastName ?? "")")
        self.setTextLabel(self.story?.text)
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

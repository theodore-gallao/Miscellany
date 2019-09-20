//
//  HomeViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class HomeViewController: UIViewController {
    
    // Data
    let textSettings: TextSettings = TextSettings()
    
    private(set) var storyModels = [
        StoryModel(
            id: "000",
            dateCreated: Date(),
            dateUpdated: Date(),
            title: "Dancing in the Sea",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida",
            author: UserModel(
                id: "000",
                dateCreated: Date(),
                dateUpdated: Date(),
                firstName: "Andrew",
                lastName: "Smith",
                imageUrl: nil),
            genres: [GenreModel](),
            tags: [String](),
            coverImageUrl: nil,
            text: "\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.\n\n\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.",
            rating: 4.1,
            viewCount: 274_182,
            commentCount: 463),
        
        StoryModel(
            id: "001",
            dateCreated: Date(),
            dateUpdated: Date(),
            title: "Dazed and Dizzy",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida",
            author: UserModel(
                id: "001",
                dateCreated: Date(),
                dateUpdated: Date(),
                firstName: "Sarah",
                lastName: "Kim",
                imageUrl: nil),
            genres: [GenreModel](),
            tags: [String](),
            coverImageUrl: nil,
            text: "\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.\n\n\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.",
            rating: 4.7,
            viewCount: 891_140,
            commentCount: 1_256),
        
        StoryModel(
            id: "002",
            dateCreated: Date(),
            dateUpdated: Date(),
            title: "The Night of Our Lives",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida",
            author: UserModel(
                id: "002",
                dateCreated: Date(),
                dateUpdated: Date(),
                firstName: "Lauren",
                lastName: "Morris",
                imageUrl: nil),
            genres: [GenreModel](),
            tags: [String](),
            coverImageUrl: nil,
            text: "\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.\n\n\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.",
            rating: 3.9,
            viewCount: 175_294,
            commentCount: 235),
        
        StoryModel(
            id: "003",
            dateCreated: Date(),
            dateUpdated: Date(),
            title: "The Trip I Didn't Know I Needed",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida",
            author: UserModel(
                id: "003",
                dateCreated: Date(),
                dateUpdated: Date(),
                firstName: "Boris",
                lastName: "Pavlov",
                imageUrl: nil),
            genres: [GenreModel](),
            tags: [String](),
            coverImageUrl: nil,
            text: "\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.\n\n\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.",
            rating: 4.3,
            viewCount: 1_257_623,
            commentCount: 2_256),
        
        StoryModel(
            id: "004",
            dateCreated: Date(),
            dateUpdated: Date(),
            title: "Natural Walls",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida",
            author: UserModel(
                id: "004",
                dateCreated: Date(),
                dateUpdated: Date(),
                firstName: "Warren",
                lastName: "Harrison",
                imageUrl: nil),
            genres: [GenreModel](),
            tags: [String](),
            coverImageUrl: nil,
            text: "\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.\n\n\tLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.\n\n\tEtiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.",
            rating: 4.4,
            viewCount: 690_251,
            commentCount: 702),
    ]
    
    private let images = [
        UIImage(named: "Book Cover 1"),
        UIImage(named: "Book Cover 2"),
        UIImage(named: "Book Cover 3"),
        UIImage(named: "Book Cover 4"),
        UIImage(named: "Book Cover 5")
    ]
    
    // Reusable collection view cell identifiers
    private let regularSectionCollectionViewCellId = "__REGULAR_SECTION_COLLECTION_VIEW_CELL_ID__"
    private let largeSectionCollectionViewCellId = "__LARGE_SECTION_COLLECTION_VIEW_CELL_ID__"
    private let rankedSectionCollectionViewCellId = "__RANKED_SECTION_COLLECTION_VIEW_CELL_ID__"
    
    // Generic kind and identifiers
    private let genericKind = "generic"
    private let genericId = "__GENERIC_ID__"
    
    // Group Header kind and identifiers
    private let groupHeaderKind = "group header"
    private let groupHeaderId = "__GROUP_HEADER_ID__"
    
    // Header kind and identifiers
    private let headerKind = "header"
    private let headerId = "__HEADER_ID__"
    
    // Footer kind and identifiers
    private let footerKind = "footer"
    private let footerId = "__FOOTER_ID__"
    
    private let sections = [
        SectionModel(
            id: "001",
            dateCreated: Date(),
            dateUpdated: Date(),
            displayType: .regular,
            name: "Recently Read",
            description: "Stories to which you might want to come back",
            moreDescription: "More Stories You've Read"),
        SectionModel(
            id: "002",
            dateCreated: Date(),
            dateUpdated: Date(),
            displayType: .regular,
            name: "Recommended For You",
            description: "We think you'll enjoy reading these stories",
            moreDescription: "More Recommendations"),
        SectionModel(
            id: "100",
            dateCreated: Date(),
            dateUpdated: Date(),
            displayType: .ranked,
            name: "Top Stories",
            description: "This month's best stories",
            moreDescription: "More Top Stories"),
        SectionModel(
            id: "003",
            dateCreated: Date(),
            dateUpdated: Date(),
            displayType: .regular,
            name: "New Stories",
            description: "Fresh from your favorite authors and genres",
            moreDescription: "More New Stories"),
        SectionModel(
            id: "101",
            dateCreated: Date(),
            dateUpdated: Date(),
            displayType: .ranked,
            name: "Trending Stories",
            description: "These have been getting a lot of attention lately",
            moreDescription: "More Top Stories"),
        SectionModel(
            id: "200",
            dateCreated: Date(),
            dateUpdated: Date(),
            displayType: .regular,
            name: "Inspirational",
            description: "Stories that will keep you motivated",
            moreDescription: "More Inspirational"),
    ]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.delaysContentTouches = true
        collectionView.refreshControl = self.refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            RegularStoryCollectionViewCell.self,
            forCellWithReuseIdentifier: self.regularSectionCollectionViewCellId)
        collectionView.register(
            LargeStoryCollectionViewCell.self,
            forCellWithReuseIdentifier: self.largeSectionCollectionViewCellId)
        collectionView.register(
            CompactStoryCollectionViewCell.self,
            forCellWithReuseIdentifier: self.rankedSectionCollectionViewCellId)
        
        collectionView.register(
            GenericReusableView.self,
            forSupplementaryViewOfKind: self.genericKind,
            withReuseIdentifier: self.genericId)
        collectionView.register(
            HeaderReusableView.self,
            forSupplementaryViewOfKind: self.headerKind,
            withReuseIdentifier: self.headerId)
        collectionView.register(
            FooterReusableView.self,
            forSupplementaryViewOfKind: self.footerKind,
            withReuseIdentifier: self.footerId)
        collectionView.register(
            GroupHeaderReusableView.self,
            forSupplementaryViewOfKind: self.groupHeaderKind,
            withReuseIdentifier: self.groupHeaderId)
        
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        // The layout will return the appropriate section based on the section
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // Get category and type to determine appropriate section
            let sectionModel = self.sections[sectionIndex]
            let type = sectionModel.displayType
            
            let item = self.makeCollectionLayoutItem(type: type)
            let group = self.makeCollectionLayoutGroup(type: type, subItem: item)
            let header = self.makeCollectionLayoutHeader()
            let footer = self.makeCollectionLayoutFooter(isEmpty: sectionModel.moreDescription == nil)
            let section = self.makeCollectionLayoutSection(
                type: type,
                group: group,
                header: header,
                footer: footer)
            
            return section
        }
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "Text")
        refreshControl.addTarget(self, action: #selector(self.handleRefreshControl(_:)), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    // MARK: View Controller States
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Extend layout past navigation and tab bars
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top]
        
        self.view.backgroundColor = UIColor(named: "Background")
        self.view.addSubview(self.collectionView)
        
        self.configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation(animated)
    }
    
    //MARK: Layout & Constraints
    internal var collectionViewConstraints = [NSLayoutConstraint]()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    internal func configureLayout() {
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(
                equalTo: self.view.topAnchor,
                constant: 0),
            self.collectionView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: 0),
            self.collectionView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: 0),
            self.collectionView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor,
                constant: 0)
        ]
        
        NSLayoutConstraint.activate(self.collectionViewConstraints)
    }
}

// MARK: Navigation
private extension HomeViewController {
    private func configureNavigation(_ animated: Bool) {
        self.configureNavigationBar(animated)
    }
    
    private func configureNavigationBar(_ animated: Bool) {
        self.configureNavigationBarAppearance(animated)
        
        self.navigationItem.title = "Home"
    }
    
    private func configureNavigationBarAppearance(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.setToolbarHidden(true, animated: animated)
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = false
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            navigationController.navigationBar.barTintColor = UIColor(named: "Background")
            navigationController.navigationBar.barStyle = .default
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
            ]
            navigationController.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.black)
            ]
        }
    }
}

// MARK: Collection Layout
extension HomeViewController {
    private func makeCollectionLayoutItem(type: SectionDisplayType) -> NSCollectionLayoutItem {
        let itemSize: NSCollectionLayoutSize
        
        switch type {
        // If regular or large, the item will span the entire width and height of the encapsulating group
        case .regular, .large:
            itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            
        // If ranked, the item will span the entire width of the encapsulating group
        // But the height will be a fixed value of 200 points
        case .ranked:
            itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2))
        }
        
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }
    
    private func makeCollectionLayoutGroup(type: SectionDisplayType, subItem: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
        let regularSectionGroupWidth = self.traitCollection.horizontalSizeClass == .compact ?
            (marginedWidth - 10) / 2 : (marginedWidth - 30) / 4
        let regularSectionGroupHeight = (regularSectionGroupWidth * (9 / 6)) + 50
        let compactHeight: NSCollectionLayoutDimension
        if type == .regular {
            compactHeight = .absolute(regularSectionGroupHeight)
        } else if type == .large {
            compactHeight = .absolute(regularSectionGroupHeight - 50)
        } else {
            compactHeight = .absolute(marginedWidth + 10) // Height of
        }
        
        let groupSize = self.traitCollection.horizontalSizeClass == .compact ?
            NSCollectionLayoutSize(
                widthDimension: type == .regular ? .absolute(regularSectionGroupWidth) : .absolute(marginedWidth),
                heightDimension: compactHeight) :
            NSCollectionLayoutSize(
                widthDimension: .absolute(regularSectionGroupWidth),
                heightDimension: .absolute(regularSectionGroupHeight))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: subItem,
            count: type == .ranked ? 5 : 1)
        group.interItemSpacing = .fixed(10)
        
        if type == .ranked {
            group.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 10, trailing: 0)
            group.supplementaryItems = [self.makeCollectionLayoutGroupHeader()]
        } else {
            group.supplementaryItems = []
        }
        
        return group
    }
    
    private func makeCollectionLayoutGroupHeader() -> NSCollectionLayoutSupplementaryItem {
        let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
        let groupHeaderSize = NSCollectionLayoutSize(
            widthDimension: .absolute(marginedWidth),
            heightDimension: .absolute(32))
        let groupHeader = NSCollectionLayoutSupplementaryItem(
            layoutSize: groupHeaderSize,
            elementKind: self.groupHeaderKind,
            containerAnchor: NSCollectionLayoutAnchor(
                edges: .top,
                absoluteOffset: CGPoint(
                    x: 0,
                    y: -5)))
        
        return groupHeader
    }
    
    private func makeCollectionLayoutHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(75))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: self.headerKind,
            alignment: .top)
        header.pinToVisibleBounds = false
        
        return header
    }
    
    private func makeCollectionLayoutFooter(isEmpty: Bool) -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(isEmpty ? 16 : 85))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: isEmpty ? self.genericKind : self.footerKind,
            alignment: .bottom)
        
        return footer
    }
    
    private func makeCollectionLayoutSection(type: SectionDisplayType, group: NSCollectionLayoutGroup, header: NSCollectionLayoutBoundarySupplementaryItem, footer: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header, footer]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary //type == .regular ? .continuousGroupLeadingBoundary : .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: self.view.layoutMargins.left,
            bottom: 0,
            trailing: self.view.layoutMargins.right)
        section.interGroupSpacing = 10
        
        return section
    }
}

// MARK: Collection View
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.sections[section].displayType == .regular {
            return 8
        } else if self.sections[section].displayType == .ranked {
            return 20
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = self.sections[indexPath.section].displayType
        
        let cell: UICollectionViewCell
        
        if type == .regular {
            // Regular
            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.regularSectionCollectionViewCellId, for: indexPath) as! RegularStoryCollectionViewCell
            regularCell.set(self.storyModels[indexPath.row % 5])
            regularCell.set(self.images[indexPath.row % 5])
            
            cell = regularCell
            
        } else if type == .large {
            // Large
            let largeCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.largeSectionCollectionViewCellId, for: indexPath) as! LargeStoryCollectionViewCell
            largeCell.set(self.storyModels[indexPath.row % 5])
            largeCell.set(self.images[indexPath.row % 5])
            
            cell = largeCell
        } else {
            // Ranked
            let compactCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.rankedSectionCollectionViewCellId, for: indexPath) as! CompactStoryCollectionViewCell
            compactCell.set(self.storyModels[indexPath.row % 5])
            compactCell.set(self.images[indexPath.row % 5])
            compactCell.set((indexPath.row % 5) + 1)
            
            cell = compactCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyViewController = StoryViewController(
            storyModel: self.storyModels[indexPath.row % 5],
            textSettings: self.textSettings)
        storyViewController.set(self.images[indexPath.row % 5])
        storyViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(storyViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.sections[indexPath.section]
        let reusableView: UICollectionReusableView
        
        if kind == self.genericKind {
            let genericReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: self.genericKind,
                withReuseIdentifier: self.genericId,
                for: indexPath) as! GenericReusableView
            reusableView = genericReusableView
        } else if kind == self.headerKind {
            let headerReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: self.headerKind,
                withReuseIdentifier: self.headerId,
                for: indexPath) as! HeaderReusableView
            headerReusableView.set(title: section.name, subtitle: section.description)
            if self.sections[indexPath.section].id == "000" {
                headerReusableView.titleLabel.textColor = UIColor(named: "Primary")
            } else {
                headerReusableView.titleLabel.textColor = UIColor(named: "Text")
            }
            reusableView = headerReusableView
        } else if kind == self.groupHeaderKind {
            let groupHeaderReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: self.groupHeaderKind,
                withReuseIdentifier: self.groupHeaderId,
                for: indexPath) as! GroupHeaderReusableView
            groupHeaderReusableView.set(title: "GENRE NAME")
            reusableView = groupHeaderReusableView
        } else {
            let footerReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: self.footerKind,
                withReuseIdentifier: self.footerId,
                for: indexPath) as! FooterReusableView
            footerReusableView.set(title: section.moreDescription)
            reusableView = footerReusableView
        }
        
        return reusableView
    }
}

// MARK: Selectors
extension HomeViewController {
    @objc private func handleRefreshControl(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.collectionView.reloadData()
            sender.endRefreshing()
        }
    }
    
    @objc private func handleComposeButton(_ sender: UIButton) {
        
    }
}

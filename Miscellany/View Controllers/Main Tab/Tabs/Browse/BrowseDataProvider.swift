//
//  BrowseDataProvider.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import Combine

protocol BrowseDataProviderDelegate: class {
    func browseDataProviderDidUpdate(_ browseDataProvider: BrowseDataProvider)
}

class BrowseDataProvider {
    weak var delegate: BrowseDataProviderDelegate?
    
    private let storyService: StoryService
    private let imageService: ImageService
    
    init(storyService: StoryService = .shared, imageService: ImageService = .shared) {
        self.storyService = storyService
        self.imageService = imageService
    }
    
    private var items: [BrowseViewController.Item] = [
        BrowseViewController.Item(section: .browseGeneral, type: .general, targetId: "000"),
        BrowseViewController.Item(section: .browseGeneral, type: .general, targetId: "001"),
        BrowseViewController.Item(section: .browseGeneral, type: .general, targetId: "002"),
        BrowseViewController.Item(section: .browseGeneral, type: .general, targetId: "003"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "000"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "001"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "002"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "003"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "004"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "005"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "006"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "007"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "008"),
        BrowseViewController.Item(section: .genres, type: .genre, targetId: "009")
    ]
    
    // Hard coded
    private(set) var general: [String: BaseGeneral] = [
        "000": BaseGeneral(id: "000", title: "All", subtitle: "See all of Miscellany's stories", type: .stories),
        "001": BaseGeneral(id: "001", title: "Authors", subtitle: "Explore authors", type: .users),
        "002": BaseGeneral(id: "002", title: "Tags", subtitle: "Explore tags", type: .tags),
        "003": BaseGeneral(id: "003", title: "Contests", subtitle: "Miscellany's monthly contests", type: .contests),
    ]
    
    private(set) var genres: [String: BaseGenre] = [
        "000": BaseGenre(id: "000", title: "All", storyCount: Int(arc4random_uniform(10_000))),
        "001": BaseGenre(id: "001", title: "Adventure", storyCount: Int(arc4random_uniform(10_000))),
        "002": BaseGenre(id: "002", title: "Dystopian", storyCount: Int(arc4random_uniform(10_000))),
        "003": BaseGenre(id: "003", title: "Fantasy", storyCount: Int(arc4random_uniform(10_000))),
        "004": BaseGenre(id: "004", title: "Horror", storyCount: Int(arc4random_uniform(10_000))),
        "005": BaseGenre(id: "005", title: "Inspirational", storyCount: Int(arc4random_uniform(10_000))),
        "006": BaseGenre(id: "006", title: "Mystery", storyCount: Int(arc4random_uniform(10_000))),
        "007": BaseGenre(id: "007", title: "Romance", storyCount: Int(arc4random_uniform(10_000))),
        "008": BaseGenre(id: "008", title: "Science Fiction", storyCount: Int(arc4random_uniform(10_000))),
        "009": BaseGenre(id: "009", title: "Thriller", storyCount: Int(arc4random_uniform(10_000))),
        "010": BaseGenre(id: "010", title: "Western", storyCount: Int(arc4random_uniform(10_000))),
    ]
    
    var sections: [BrowseViewController.Section] {
        return [
            .browseGeneral,
            .genres
        ]
    }
    
    func items(for section: BrowseViewController.Section) -> [BrowseViewController.Item]? {
        return self.items.filter {
            return $0.section == section
        }
    }
    
    func startObserving() {
        self.delegate?.browseDataProviderDidUpdate(self)
    }
    
    func stopObserving() {
        
    }
}

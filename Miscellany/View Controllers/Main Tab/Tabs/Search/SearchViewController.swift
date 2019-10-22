//
//  SearchViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/8/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: SectionCollectionViewController {
    let imageService: ImageService
    
    private(set) var sections: [SectionModel] = []
    private(set) var items: [SectionModel: [Itemable]] = [:]
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsScopeBar = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Stories, users, or tags"
        searchController.searchBar.scopeButtonTitles = ["Stories", "Users", "Tags"]
        
        return searchController
    }()
    
    // MARK: Initializers
    init(imageService: ImageService) {
        self.imageService = imageService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Properties
extension SearchViewController {
    override func configureProperties() {
        super.configureProperties()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top]
    }
}

// MARK: Additional
extension SearchViewController {
    override func configureAdditional() {
        super.configureAdditional()
    }
}

// MARK: Views, Layout & Constraints
extension SearchViewController {
    override func configureViews() {
        super.configureViews()
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        self.navigationController?.navigationBar.directionalLayoutMargins = self.display.directionalLayoutMargins
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
    }
    
    override func activateConstraints() {
        super.activateConstraints()
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
    }
}

// MARK: Navigation
extension SearchViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Search"
        self.navigationItem.searchController = self.searchController
    }
}

// MARK: Search Controller
extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func willPresentSearchController(_ searchController: UISearchController) {
        self.collectionView.reloadData()
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        self.collectionView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.collectionView.reloadData()
    }
}

// MARK: Search Bar
extension SearchViewController: UISearchBarDelegate {
    
}

// MARK: State & Scope
extension SearchViewController {
    enum State {
        case notSearching
        case searchingRecent
        case searchingResult
    }
    
    enum Scope {
        case none
        case stories
        case users
        case tags
    }
    
    var state: State {
        if self.searchController.isBeingPresented {
            return .notSearching
        } else {
            if self.searchController.searchBar.text?.isEmpty ?? true {
                return .searchingRecent
            } else {
                return .searchingResult
            }
        }
    }
    
    var scope: Scope {
        if self.state == .notSearching {
            return .none
        } else if self.searchController.searchBar.selectedScopeButtonIndex == 0 {
            return .stories
        } else if self.searchController.searchBar.selectedScopeButtonIndex == 1 {
            return .users
        } else {
            return .tags
        }
    }
}

// MARK: Section Collection View
extension SearchViewController: SectionCollectionViewControllerDelegate, SectionCollectionViewControllerDataSource {
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, groupTitleAtIndex index: Int, fromSection section: SectionModel) -> String? {
        return nil
    }
    
    func numberOfSections(in sectionCollectionViewController: SectionCollectionViewController) -> Int {
        return self.sections.count
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, sectionAtIndex index: Int) -> SectionModel {
        return self.sections[index]
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, numberOfItemsInSection section: SectionModel) -> Int {
        return self.items[section]?.count ?? 0
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, itemAtIndex index: Int, fromSection section: SectionModel) -> Itemable {
        return BaseStoryModel(id: "000", title: "Test Title", author: BaseUserModel(id: "000", firstName: "First", lastName: "Last", subscriberCount: 0))
    }
}

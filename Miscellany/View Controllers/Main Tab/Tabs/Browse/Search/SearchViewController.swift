//
//  SearchViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/15/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: BaseViewController {
    
}

extension SearchViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
    }
}

// MARK: Search Controller
extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: Search Bar
extension SearchViewController: UISearchBarDelegate {
    
}

//
//  Section.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/16/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class GenreService {
    var favoriteGenres: [GenreModel]?
    var allGenres: [GenreModel]?
    
    /// The singleton that represents the *only* instance of this class
    static let shared = GenreService()
    
    private init() {}
    
    /// This function must be called *only once* and *before* any other method from this `UserService` is called
    func configure() {}
}

class QueryService {
    /// The singleton that represents the *only* instance of this class
    static let shared = QueryService()
    
    private init() {}
    
    /// This function must be called *only once* and *before* any other method from this `UserService` is called
    func configure() {}
    
    func query(for query: QueryModel, completion: @escaping(Any?) -> ()) {
        
    }
}

struct QueryModel: Codable, Hashable {
    enum Query: String, Codable {
        case announcement
        case story
        case user
        case genre
        case tag
    }
    
    enum Filter: String, Codable {
        case none
        case id
        case story
        case user
        case genre
        case tag
        case search
        case dateCreated
        case trendingScore
    }
    
    enum Order: String, Codable {
        case ascending
        case descending
    }
    
    var query: Query
    var filter: Filter
    var order: Order
    var limit: Int
}

struct DisplayProperty<T: Hashable>: Hashable {
    var compact: T
    var standard: T
    var large: T
    var extraLarge: T
    
    init(_ allValues: T) {
        self.compact = allValues
        self.standard = allValues
        self.large = allValues
        self.extraLarge = allValues
    }
    
    init(compact: T, standard: T, large: T, extraLarge: T) {
        self.compact = compact
        self.standard = standard
        self.large = large
        self.extraLarge = extraLarge
    }
    
    func value(for displayMode: DisplayMode) -> T {
        switch displayMode {
        case .compact: return self.compact
        case .standard: return self.standard
        case .large: return self.large
        case .extraLarge: return self.extraLarge
        }
    }
}

struct ItemProperties: Hashable {
    var configuration: SectionItemCollectionViewCell.Configuration
    var itemCount: DisplayProperty<Int>
    var heightConstant: DisplayProperty<CGFloat>
    var spacingConstant: DisplayProperty<CGFloat> = .init(0)
    var imageAspectRatio: CGFloat
    var imageCornerRadius: DisplayProperty<CGFloat>
    var shouldIgnoreImageAspectRatioForGroupHeight: Bool
    var textAlignment: NSTextAlignment
    
    var headlineAlpha: CGFloat
    var headlineTextColor: UIColor?
    var headlineFont: UIFont
    
    var titleFont: UIFont
}

struct GroupProperties: Hashable {
    var isHeaderEnabled: Bool
    var columnCount: DisplayProperty<CGFloat>
    var layoutDirection: UICollectionView.ScrollDirection
}

struct SectionProperties: Hashable {
    var title: String?
    var description: String?
    var actionTitle: String?
    var actionImage: UIImage?
    
    var orthagonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    var indicatorStyle: SectionHeaderCollectionReusableView.IndicatorStyle
}

struct SectionModel: Hashable {
    var properties: SectionProperties
    var itemProperties: ItemProperties
    var groupProperties: GroupProperties
}

//
//  Section.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

enum SectionDisplayType: Int, Codable {
    case regular
    case large
    case ranked
}

enum Section: String {
    // Sections related only to the user
    case recentlyRead = "Recently Read"
    case recommendedForYou = "Recommended For You"
    case newStories = "New Stories"
    
    // Ranked sections
    case topStories = "Top Stories"
    case trendingStories = "Trending Stories"
    
    // Sections where stories are similar to a story the user has read
    case storiesLike = "Stories Like"
    
    // Sections based on genres
    case genre = "Genre"
}

struct SectionModel {
    // Category
    var type: Section
    var displayType: SectionDisplayType
    var name: String
    var description: String
    var genre: Genre?
    
    init(section: Section, genre: Genre? = nil, storyName: String? = nil) {
        self.type = section
        self.displayType = SectionModel.displayType(for: section)
        self.name = SectionModel.name(from: section, genre: genre, storyName: storyName)
        self.description = SectionModel.description(for: section, genre: genre, storyName: storyName)
    }
    
    static func displayType(for section: Section) -> SectionDisplayType {
        switch section {
        case .recentlyRead: return .regular
        case .recommendedForYou: return .regular
        case .newStories: return .regular
        case .topStories: return .ranked
        case .trendingStories: return .ranked
        case .storiesLike: return .regular
        case .genre: return .regular
        }
    }
    
    static func name(from section: Section, genre: Genre?, storyName: String?) -> String {
        switch section {
        case .storiesLike: return "Stories like \(storyName ?? "")"
        case .genre: return genre?.rawValue ?? ""
        default: return section.rawValue
        }
    }
    
    static func description(for section: Section, genre: Genre?, storyName: String?) -> String {
        switch section {
        case .recentlyRead: return "Stories you might want to read again"
        case .recommendedForYou: return "We think you'll enjoy reading these stories"
        case .newStories: return "Fresh from genres and authors your like"
        case .topStories: return "The best stories from this week"
        case .trendingStories: return "These stories have been getting attention lately"
        case .storiesLike: return "If you liked \(storyName ?? ""), you might enjoy these stories"
        case .genre:
            guard let genre = genre else { return "" }
            return "Popular \(genre.rawValue) stories"
        }
    }
}

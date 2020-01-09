//
//  HomeDataProvider.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import Combine

protocol HomeDataProviderDelegate: class {
    func homeDataProviderDidUpdate(_ homeDataProvider: HomeDataProvider)
}

class HomeDataProvider {
    weak var delegate: HomeDataProviderDelegate?
    
    private let userService: UserService
    private let storyService: StoryService
    
    // Subscribers
    private var registrationSubscriber: AnyCancellable?
    
    init(userService: UserService = .shared, storyService: StoryService = .shared) {
        self.userService = userService
        self.storyService = storyService
    }
    
    private var items: [HomeViewController.Item] = [
        HomeViewController.Item(section: .headline, type: .headline, targetId: "000"),
        HomeViewController.Item(section: .headline, type: .headline, targetId: "001"),
        HomeViewController.Item(section: .headline, type: .headline, targetId: "002"),
        HomeViewController.Item(section: .headline, type: .headline, targetId: "003"),
        HomeViewController.Item(section: .recommendedForYou, type: .story, targetId: "000"),
        HomeViewController.Item(section: .recommendedForYou, type: .story, targetId: "001"),
        HomeViewController.Item(section: .recommendedForYou, type: .story, targetId: "002"),
        HomeViewController.Item(section: .recommendedForYou, type: .story, targetId: "003"),
        HomeViewController.Item(section: .recommendedForYou, type: .story, targetId: "004"),
        HomeViewController.Item(section: .authorsForYou, type: .user, targetId: "000"),
        HomeViewController.Item(section: .authorsForYou, type: .user, targetId: "001"),
        HomeViewController.Item(section: .authorsForYou, type: .user, targetId: "002"),
        HomeViewController.Item(section: .authorsForYou, type: .user, targetId: "003"),
        HomeViewController.Item(section: .authorsForYou, type: .user, targetId: "004"),
        HomeViewController.Item(section: .newForYou, type: .story, targetId: "000"),
        HomeViewController.Item(section: .newForYou, type: .story, targetId: "001"),
        HomeViewController.Item(section: .newForYou, type: .story, targetId: "002"),
        HomeViewController.Item(section: .newForYou, type: .story, targetId: "003"),
        HomeViewController.Item(section: .newForYou, type: .story, targetId: "004"),
        HomeViewController.Item(section: .tagsForYou, type: .tag, targetId: "000"),
        HomeViewController.Item(section: .tagsForYou, type: .tag, targetId: "001"),
        HomeViewController.Item(section: .tagsForYou, type: .tag, targetId: "002"),
        HomeViewController.Item(section: .tagsForYou, type: .tag, targetId: "003"),
        HomeViewController.Item(section: .tagsForYou, type: .tag, targetId: "004"),
        HomeViewController.Item(section: .newAndTrending, type: .story, targetId: "000"),
        HomeViewController.Item(section: .newAndTrending, type: .story, targetId: "001"),
        HomeViewController.Item(section: .newAndTrending, type: .story, targetId: "002"),
        HomeViewController.Item(section: .newAndTrending, type: .story, targetId: "003"),
        HomeViewController.Item(section: .newAndTrending, type: .story, targetId: "004"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "000", secondaryTargetId: "000"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "001", secondaryTargetId: "000"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "002", secondaryTargetId: "000"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "003", secondaryTargetId: "000"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "004", secondaryTargetId: "000"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "000", secondaryTargetId: "001"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "001", secondaryTargetId: "001"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "002", secondaryTargetId: "001"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "003", secondaryTargetId: "001"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "004", secondaryTargetId: "001"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "000", secondaryTargetId: "002"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "001", secondaryTargetId: "002"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "002", secondaryTargetId: "002"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "003", secondaryTargetId: "002"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "004", secondaryTargetId: "002"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "000", secondaryTargetId: "003"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "001", secondaryTargetId: "003"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "002", secondaryTargetId: "003"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "003", secondaryTargetId: "003"),
        HomeViewController.Item(section: .topCharts, type: .rankedStory, targetId: "004", secondaryTargetId: "003"),
        HomeViewController.Item(section: .ourFavorites, type: .story, targetId: "000"),
        HomeViewController.Item(section: .ourFavorites, type: .story, targetId: "001"),
        HomeViewController.Item(section: .ourFavorites, type: .story, targetId: "002"),
        HomeViewController.Item(section: .ourFavorites, type: .story, targetId: "003"),
        HomeViewController.Item(section: .ourFavorites, type: .story, targetId: "004"),
        HomeViewController.Item(section: .popularAuthors, type: .user, targetId: "000"),
        HomeViewController.Item(section: .popularAuthors, type: .user, targetId: "001"),
        HomeViewController.Item(section: .popularAuthors, type: .user, targetId: "002"),
        HomeViewController.Item(section: .popularAuthors, type: .user, targetId: "003"),
        HomeViewController.Item(section: .popularAuthors, type: .user, targetId: "004"),
        HomeViewController.Item(section: .popularTags, type: .tag, targetId: "000"),
        HomeViewController.Item(section: .popularTags, type: .tag, targetId: "001"),
        HomeViewController.Item(section: .popularTags, type: .tag, targetId: "002"),
        HomeViewController.Item(section: .popularTags, type: .tag, targetId: "003"),
        HomeViewController.Item(section: .popularTags, type: .tag, targetId: "004"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "000"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "001"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "002"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "003"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "004"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "005"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "006"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "007"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "008"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "009"),
        HomeViewController.Item(section: .genres, type: .genre, targetId: "010"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "000", secondaryTargetId: "000"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "001", secondaryTargetId: "000"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "002", secondaryTargetId: "000"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "003", secondaryTargetId: "000"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "004", secondaryTargetId: "000"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "000", secondaryTargetId: "001"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "001", secondaryTargetId: "001"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "002", secondaryTargetId: "001"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "003", secondaryTargetId: "001"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "004", secondaryTargetId: "001"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "000", secondaryTargetId: "002"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "001", secondaryTargetId: "002"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "002", secondaryTargetId: "002"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "003", secondaryTargetId: "002"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "004", secondaryTargetId: "002"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "000", secondaryTargetId: "003"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "001", secondaryTargetId: "003"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "002", secondaryTargetId: "003"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "003", secondaryTargetId: "003"),
        HomeViewController.Item(section: .contests, type: .rankedStory, targetId: "004", secondaryTargetId: "003"),
    ]
    
    private(set) var headlines: [String: BaseHeadline] = [
        "000": BaseHeadline(id: "000", type: .story, targetId: "000", heading: "MONTHLY CONTEST", title: "October 2019 - Horror", subtitle: "This contest has ended! See the results"),
        "001": BaseHeadline(id: "001", type: .story, targetId: "000", heading: "NEW STORY", title: "That One Night", subtitle: "Linda Mendes"),
        "002": BaseHeadline(id: "002", type: .story, targetId: "000", heading: "AUTHOR SPOTLIGHT", title: "Linda Mendes", subtitle: "Reached 50,000 subscribers!"),
        "003": BaseHeadline(id: "003", type: .story, targetId: "000", heading: "MONTHLY CONTEST", title: "October 2019 - Horror", subtitle: "This contest has begun!"),
    ]
    
    private (set) var stories: [String: BaseStory] = [
        "000": BaseStory(id: "000", title: "Allure of the Tropics", author: BaseUser(id: "000", firstName: "Jonathan", lastName: "Appleseed", username: "j_appleseed")),
        "001": BaseStory(id: "001", title: "That One Night", author: BaseUser(id: "001", firstName: "Linda", lastName: "Mendes", username: "_itslinda")),
        "002": BaseStory(id: "002", title: "Abstract Thought", author: BaseUser(id: "002", firstName: "Arthur", lastName: "Adams", username: "real_arthur_adams")),
        "003": BaseStory(id: "003", title: "Off the Coast", author: BaseUser(id: "003", firstName: "Abigail", lastName: "Larsson", username: "abbylarson94")),
        "004": BaseStory(id: "004", title: "Between the Mountain", author: BaseUser(id: "004", firstName: "Eric", lastName: "Cruz", username: "cruzing_"))
    ]
    
    private(set) var users: [String: BaseUser] = [
        "000": BaseUser(id: "000", firstName: "Jonathan", lastName: "Appleseed", username: "j_appleseed"),
        "001": BaseUser(id: "001", firstName: "Linda", lastName: "Mendes", username: "_itslinda"),
        "002": BaseUser(id: "002", firstName: "Arthur", lastName: "Adams", username: "real_arthur_adams"),
        "003": BaseUser(id: "003", firstName: "Abigail", lastName: "Larsson", username: "abbylarson94"),
        "004": BaseUser(id: "004", firstName: "Eric", lastName: "Cruz",  username: "cruzing_")
    ]
    
    private(set) var tags: [String: BaseTag] = [
        "000": BaseTag(id: "000", title: "superhero", storyCount: Int(arc4random_uniform(10_000))),
        "001": BaseTag(id: "001", title: "crime fighting", storyCount: Int(arc4random_uniform(10_000))),
        "002": BaseTag(id: "002", title: "heartbreak", storyCount: Int(arc4random_uniform(10_000))),
        "003": BaseTag(id: "003", title: "sight seeing", storyCount: Int(arc4random_uniform(10_000))),
        "004": BaseTag(id: "004", title: "close encounter", storyCount: Int(arc4random_uniform(10_000))),
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
    
    private(set) var contests: [String: BaseContest] = [
        "000": BaseContest(id: "000", title: "November, 2019 - Science Fiction"),
        "001": BaseContest(id: "001", title: "October, 2019 - Horror"),
        "002": BaseContest(id: "002", title: "September, 2019 - Fantasy"),
        "003": BaseContest(id: "003", title: "August, 2019 - Western"),
        "004": BaseContest(id: "004", title: "July, 2019 - Adventure"),
    ]
    
    var sections: [HomeViewController.Section] {
        if self.userService.currentUser.isRegistered {
            return [
                .headline,
                .recommendedForYou,
                .authorsForYou,
                .newForYou,
                .tagsForYou,
                .newAndTrending,
                .topCharts,
                .ourFavorites,
                .popularAuthors,
                .genres,
                .popularTags,
                .contests
            ]
        } else {
            return [
                .headline,
                .newAndTrending,
                .topCharts,
                .ourFavorites,
                .popularAuthors,
                .genres,
                .popularTags,
                .contests
            ]
        }
    }
    
    func items(for section: HomeViewController.Section) -> [HomeViewController.Item]? {
        return self.items.filter {
            return $0.section == section
        }
    }
    
    func startObserving() {
        self.configureRegistrationSubscriber()
        
        self.delegate?.homeDataProviderDidUpdate(self)
    }
    
    func stopObserving() {
        self.registrationSubscriber = nil
    }
    
    private func configureRegistrationSubscriber() {
        self.registrationSubscriber = self.userService.registrationPublisher
            .sink(receiveValue: { [weak self] (isRegistered) in
                if let this = self {
                    this.delegate?.homeDataProviderDidUpdate(this)
                }
            })
    }
}

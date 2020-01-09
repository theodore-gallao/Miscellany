//
//  NotificationDataProvider.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import Combine

protocol NotificationDataProviderDelegate: class {
    func notificationDataProviderDidUpdate(_ notificationDataProvider: NotificationDataProvider)
}

class NotificationDataProvider {
    weak var delegate: NotificationDataProviderDelegate?
    
    private let userService: UserService
    private let imageService: ImageService
    
    // Subscribers
    private var registrationSubscriber: AnyCancellable?
    
    init(userService: UserService = .shared, imageService: ImageService = .shared) {
        self.userService = userService
        self.imageService = imageService
    }
    
    private var items: [NotificationViewController.Item] = [
        NotificationViewController.Item(section: .all, type: .notification, targetId: "000"),
        NotificationViewController.Item(section: .all, type: .notification, targetId: "001"),
        NotificationViewController.Item(section: .all, type: .notification, targetId: "002"),
        NotificationViewController.Item(section: .all, type: .notification, targetId: "003"),
        NotificationViewController.Item(section: .all, type: .notification, targetId: "004"),
        NotificationViewController.Item(section: .all, type: .notification, targetId: "005"),
        NotificationViewController.Item(section: .all, type: .notification, targetId: "006"),
    ]
    
    // Hard coded
    private(set) var notifications: [String: Notification] = [
        "000": Notification(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Monthly Contest", subtitle: "Miscellany's 2019 October Contest (Horror) has begun!", type: .announcement, targetId: "000", targetType: .article, isSeen: false),
        "001": Notification(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Off The Coast", subtitle: "John Appleseed and 46 others like your story.", type: .storyLike, targetId: "000", targetType: .story, isSeen: false),
        "002": Notification(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Off The Coast", subtitle: "Arthur adams and 13 others commented on your story.", type: .storyComment, targetId: "000", targetType: .comment, isSeen: false),
        "003": Notification(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Off The Coast", subtitle: "This story has reached the top 100 in its category!", type: .storyRank, targetId: "000", targetType: .story, isSeen: true),
        "004": Notification(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "You have a new subscriber", subtitle: "Linda Mendes and 7 others has subscribed to you!", type: .newSubscriber, targetId: "000", targetType: .user, isSeen: true),
        "005": Notification(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "You have been mentioned", subtitle: "Eric Cruz has mentioned you in his comment.", type: .mention, targetId: "000", targetType: .comment, isSeen: false),
        "006": Notification(id: "005", dateCreated: Date(), dateUpdated: Date(), title: "That One Night", subtitle: "Linda Mendes has published a new story.", type: .newStory, targetId: "000", targetType: .story, isSeen: true),
    ]
    
    var sections: [NotificationViewController.Section] {
        if self.userService.currentUser.isRegistered {
            return [
                .all
            ]
        } else {
            return []
        }
    }
    
    func items(for section: NotificationViewController.Section) -> [NotificationViewController.Item]? {
        return self.items.filter {
            return $0.section == section
        }
    }
    
    func startObserving() {
        self.configureRegistrationSubscriber()
        
        self.delegate?.notificationDataProviderDidUpdate(self)
    }
    
    func stopObserving() {
        self.registrationSubscriber = nil
    }
    
    private func configureRegistrationSubscriber() {
        self.registrationSubscriber = self.userService.registrationPublisher
            .sink(receiveValue: { [weak self] (isRegistered) in
                if let this = self {
                    this.delegate?.notificationDataProviderDidUpdate(this)
                }
            })
    }
}

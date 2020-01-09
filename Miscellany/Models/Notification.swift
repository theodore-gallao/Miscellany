//
//  Notification.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

extension Notification {
    enum NotificationType: String, Codable {
        // Notifications regarding every Miscellany user, or users who need to hear the announcement
        case announcement = "announcement"
        
        // Notifications regarding my stories
        case storyLike = "story like"
        case storyComment = "story comment"
        case storyRank = "story rank"
        
        // Notifications regarding me, the user
        case newSubscriber = "new subscriber"
        case mention = "mention"
        
        // Notifications regarding the users to whom I subscribe
        case newStory = "new story"
    }
    
    enum TargetType: Int, Codable {
        case article
        case comment
        case story
        case user
    }
}

struct Notification: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    var subtitle: String
    var type: NotificationType
    
    var targetId: String
    var targetType: Notification.TargetType
    
    var isSeen: Bool
}

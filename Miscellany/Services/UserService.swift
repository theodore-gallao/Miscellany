//
//  UserService.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit
import Combine
import AuthenticationServices

/// Interacts with the database for user related data **only**
class UserService {
    let registrationPublisher = PassthroughSubject<Bool, Never>()
    
    var currentUser: User {
        didSet {
            self.registrationPublisher.send(self.currentUser.isRegistered)
        }
    }
    
    /// The singleton that represents the *only* instance of this class
    static let shared = UserService()
    
    private init() {
        // TODO: Fetch user from cache first, then attempt to fetch user from database. If not, put user in both.
        self.currentUser = User(id: "000", dateCreated: Date(), dateUpdated: Date(), isRegistered: false, firstName: "First", lastName: "Last", email: "", username: "", storyCount: 0, subscriberCount: 0, subscribedCount: 0)
    }
    
    /// This function must be called *only once* and *before* any other method from this `UserService` is called
    func configure() {
        // Prepare requests for both Apple ID and password providers.
    }
    
    func presentSignIn(in viewController: UIViewController, completion: (() -> Void)?) {
        let signInViewController = SignInViewController()
        let signInNavigationController = UINavigationController(rootViewController: signInViewController)
        signInNavigationController.modalPresentationStyle = .pageSheet
            
        viewController.present(signInNavigationController, animated: true, completion: completion)
    }
}

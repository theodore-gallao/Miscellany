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

/// Interacts with the database for user related data **only**
class UserService {
    private(set) var currentUserModel: UserModel?
    let currentUser: User?
    
    /// The singleton that represents the *only* instance of this class
    static let shared = UserService(currentUser: Auth.auth().currentUser)
    
    private init(currentUser: User?) {
        self.currentUser = currentUser
    }
    
    /// This function must be called *only once* and *before* any other method from this `UserService` is called
    func configure() {}
    
    func presentSignIn(in viewController: UIViewController) {
        let signInViewController = SignInViewController()
        let signInNavigationController = UINavigationController(rootViewController: signInViewController)
        signInNavigationController.modalPresentationStyle = .pageSheet
            
        viewController.present(signInNavigationController, animated: true, completion: nil)
    }
}

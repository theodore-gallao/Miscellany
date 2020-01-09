//
//  GenreService.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/16/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class GenreService {
    var favoriteGenres: [Genre]?
    var allGenres: [Genre]?
    
    /// The singleton that represents the *only* instance of this class
    static let shared = GenreService()
    
    private init() {}
    
    /// This function must be called *only once* and *before* any other method from this `UserService` is called
    func configure() {}
}

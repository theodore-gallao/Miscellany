//
//  ImageService.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import Firebase
import UIKit

// MARK: Declaration
/// Interacts with the storage for images **only**
class ImageService {
    
    /// Errors related to `ImageService` operations
    enum ImageServiceError: Error {
        case known(_ error: Error)
        case unknown(_ description: String)
        case dataError(_ description: String)
    }
    
    /// The singleton that represents the *only* instance of this class
    static let shared = ImageService()
    
    /// The `URLSession` through which all URL-related operations are performed
    private let urlSession: URLSession
    
    /// The storage reference of the directory that contains all user images
    private let usersReference: StorageReference
    
    /// The storage reference of the directory that contains all story images
    private let storiesReference: StorageReference
    
    // Caches
    private let urlImageCache = NSCache<AnyObject, AnyObject>()
    private let userImageCache = NSCache<NSString, AnyObject>()
    private let storyImageCache = NSCache<NSString, AnyObject>()
    
    private init(
        urlSession: URLSession = .shared,
        usersReference: StorageReference = Storage.storage().reference().child("images").child("users"),
        storiesReference: StorageReference = Storage.storage().reference().child("images").child("stories"))
    {
        self.urlSession = urlSession
        self.usersReference = usersReference
        self.storiesReference = storiesReference
    }
    
    /// This function must be called *only once* and *before* any other method from this `ImageService` is called
    func configure() {}
}

// MARK: URL Images
extension ImageService {
    /**
     Loads the image from the given url. Retrieve the image through the completion block's result
     
     - Parameter url: The `URL` from which the image will be loaded
     - Parameter completion: The block that is called when the image has finished downloading. The `Result` object passed will contain either a `UIImage` if successful or an `ImageServiceError` if failed
     */
    func download(url: URL, completion: @escaping(Result<UIImage, ImageServiceError>) -> ()) {
        if let image = self.urlImageCache.object(forKey: url as AnyObject) as? UIImage {
            completion(.success(image))
            return
        }

        self.urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(.known(error)))
                return
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
                self.urlImageCache.setObject(image, forKey: url as AnyObject)
                return
            } else {
                completion(.failure(.unknown("ERROR: Unable to load image from url")))
                return
            }
        }).resume()
    }
}

// MARK: User Images
extension ImageService {
    /**
     Uploads the given user image to the storage named the given user id.
     
     - Parameter image: The `UIImage` to be uploaded
     - Parameter userId: The user id of the user represented by the image. This will also serve as the image's name in storage
     - Parameter completion: The block that is called when the image has finished uploading. The `Result` object passed will contain either a `StorageMetadata` if successful or an `ImageServiceError` if failed
     
     - Returns: The instance of `StorageUploadTask` that is uploading the given image; however, `nil` if failed to reach task
    */
    func upload(_ image: UIImage, userId: String, completion: ((Result<StorageMetadata, ImageServiceError>) -> ())?) -> StorageUploadTask? {
        let compressionQuality = self.compressionQuality(for: image, maximumHeight: 256, maximumWidth: 256)
        
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            completion?(.failure(.dataError("ERROR: Unable to convert image to data")))
            return nil
        }

        let imageRef = self.usersReference.child("\(userId).jpg")
        
        return imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                completion?(.failure(.known(error)))
                return
            } else if let metadata = metadata {
                completion?(.success(metadata))
                // Save the image in the cache
                self.userImageCache.setObject(image, forKey: userId as NSString)
                return
            } else {
                completion?(.failure(.unknown("ERROR: Unable to load image from url")))
                return
            }
        }
    }
    
    /**
     Downloads the desired user image of the given user id
     
     - Parameter userId: The user id of the user represented by the desired image. This is also the image's name in storage
     - Parameter completion: The block that is called when the image has finished downloading. The `Result` object passed will contain either a `UIImage` if successful or an `ImageServiceError` if failed
     
     - Returns: The instance of `StorageDownloadTask` that is uploading the given image; however, `nil` if failed to reach task
    */
    func download(userId: String, completion: @escaping(Result<UIImage, ImageServiceError>) -> ()) -> StorageDownloadTask? {
        if let image = self.userImageCache.object(forKey: userId as NSString) as? UIImage {
            completion(.success(image))
            return nil
        }

        let imageRef = self.usersReference.child("\(userId).jpg")
        
        // All user images should be 256 x 256, but this allows for some compression failures.
        return imageRef.getData(maxSize: 2 * 256 * 256) { (data, error) in
            if let error = error {
                completion(.failure(.known(error)))
                return
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
                self.userImageCache.setObject(image, forKey: userId as NSString)
                return
            } else {
                completion(.failure(.unknown("ERROR: Unable to load image from url")))
                return
            }
        }
    }
}

// MARK: Story Images
extension ImageService {
    /**
     Uploads the story user image to the storage named the given story id.
     
     - Parameter image: The `UIImage` to be uploaded
     - Parameter storyId: The story id of the story represented by the image. This will also serve as the image's name in storage
     - Parameter completion: The block that is called when the image has finished uploading. The `Result` object passed will contain either a `StorageMetadata` if successful or an `ImageServiceError` if failed
     
     - Returns: The instance of `StorageUploadTask` that is uploading the given image; however, `nil` if failed to reach task
    */
    func upload(_ image: UIImage, storyId: String, completion: ((Result<StorageMetadata, ImageServiceError>) -> ())?) -> StorageUploadTask? {
        let compressionQuality = self.compressionQuality(for: image, maximumHeight: 256, maximumWidth: 256)
        
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            completion?(.failure(.dataError("ERROR: Unable to convert image to data")))
            return nil
        }

        let imageRef = self.storiesReference.child("\(storyId).jpg")
        
        return imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                completion?(.failure(.known(error)))
                return
            } else if let metadata = metadata {
                completion?(.success(metadata))
                // Save the image in the cache
                self.storyImageCache.setObject(image, forKey: storyId as NSString)
                return
            } else {
                completion?(.failure(.unknown("ERROR: Unable to load image from url")))
                return
            }
        }
    }
    
    /**
     Downloads the desired story image of the given story id
     
     - Parameter storyId: The story id of the user represented by the desired image. This is also the image's name in storage
     - Parameter completion: The block that is called when the image has finished downloading. The `Result` object passed will contain either a `UIImage` if successful or an `ImageServiceError` if failed
     
     - Returns: The instance of `StorageDownloadTask` that is uploading the given image; however, `nil` if failed to reach task
    */
    func download(storyId: String, completion: @escaping(Result<UIImage, ImageServiceError>) -> ()) -> StorageDownloadTask? {
        if let image = self.storyImageCache.object(forKey: storyId as NSString) as? UIImage {
            completion(.success(image))
            return nil
        }

        let imageRef = self.storiesReference.child("\(storyId).jpg")
        
        // All story images should be 1920 x 1280, but this allows for some compression failures.
        return imageRef.getData(maxSize: 2 * 1920 * 1280) { (data, error) in
            if let error = error {
                completion(.failure(.known(error)))
                return
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
                self.storyImageCache.setObject(image, forKey: storyId as NSString)
                return
            } else {
                completion(.failure(.unknown("ERROR: Unable to load image from url")))
                return
            }
        }
    }
}

// MARK: Image Compression
extension ImageService {
    func compressionQuality(for image: UIImage, maximumHeight: CGFloat, maximumWidth: CGFloat) -> CGFloat {
        let height = image.size.height
        let width = image.size.width
        
        let compressionQuality: CGFloat
        
        if height > width && height > maximumHeight {
            compressionQuality = maximumHeight / height
        } else if width > height && width > maximumWidth {
            compressionQuality = maximumWidth / width
        } else {
            compressionQuality = 1.0
        }
        
        return compressionQuality
    }
}

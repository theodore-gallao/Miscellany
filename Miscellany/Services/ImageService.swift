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
    enum Directory: String {
        case users = "users"
        case stories = "stories"
        case genres = "genres"
    }
    
    /// Errors related to `ImageService` operations
    enum ImageServiceError: Error {
        case known(_ error: Error)
        case unknown(_ description: String)
        case dataError(_ description: String)
    }
    
    /// The singleton that represents the *only* instance of this class
    static let shared = ImageService()
    
    /// The storage reference of the directory that contains all user images
    private let imagesReference: StorageReference
    
    // Caches
    private let imageCache = NSCache<NSString, AnyObject>()
    
    private init(
        imagesReference: StorageReference = Storage.storage().reference().child("images")
    ) {
        self.imagesReference = imagesReference
    }
    
    /// This function must be called *only once* and *before* any other method from this `ImageService` is called
    func configure() {}
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
    func upload(_ image: UIImage, directory: Directory, id: String, completion: ((Result<StorageMetadata, ImageServiceError>) -> ())?) -> StorageUploadTask? {
        
        completion?(.failure(.unknown("idk lol")))
        return nil
        
        
        let compressionQuality = self.compressionQuality(for: image, maximumHeight: 1024, maximumWidth: 1024)
        
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            completion?(.failure(.dataError("ERROR: Unable to convert image to data")))
            return nil
        }
        
        let path = "\(directory.rawValue)/\(id).jpg"
        let imageRef = self.imagesReference.child(path)
        
        return imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                completion?(.failure(.known(error)))
                return
            } else if let metadata = metadata {
                completion?(.success(metadata))
                // Save the image in the cache
                self.imageCache.setObject(image, forKey: path as NSString)
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
    func download(directory: Directory, id: String, completion: @escaping(Result<UIImage, ImageServiceError>) -> ()) -> StorageDownloadTask? {
        completion(.failure(.unknown("idk lol")))
        return nil
        
        let path = "\(directory.rawValue)/\(id).jpg"
        
        if let image = self.imageCache.object(forKey: path as NSString) as? UIImage {
            completion(.success(image))
            return nil
        }

        let imageRef = self.imagesReference.child(path)
        
        // All user images should be 256 x 256, but this allows for some compression failures.
        return imageRef.getData(maxSize: 2 * 256 * 256) { (data, error) in
            if let error = error {
                completion(.failure(.known(error)))
                return
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
                self.imageCache.setObject(image, forKey: path as NSString)
                return
            } else {
                completion(.failure(.unknown("ERROR: Unable to load image from url")))
                return
            }
        }
    }
}

// MARK: Image Compression
private extension ImageService {
    private func compressionQuality(for image: UIImage, maximumHeight: CGFloat, maximumWidth: CGFloat) -> CGFloat {
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

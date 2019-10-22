//
//  StoryPreviewPageViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/6/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryPreviewPageViewController: UIPageViewController {
    let userService: UserService
    let imageService: ImageService
    
    let stories: [StoryModel]
    let firstIndex: Int
    
    init(stories: [StoryModel], firstIndex: Int, userService: UserService, imageService: ImageService) {
        self.userService = userService
        self.imageService = imageService
        
        self.stories = stories
        self.firstIndex = firstIndex
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing : 0])
        
        self.dataSource = self
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor(named: "Empty")
        appearance.currentPageIndicatorTintColor = UIColor(named: "Primary")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        if let story = self.stories[optional: self.firstIndex] {
            let storyPreviewViewController = StoryPreviewViewController(story: story, userService: self.userService, imageService: self.imageService)
            
            self.setViewControllers([storyPreviewViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation(animated)
    }
}

// MARK: Navigation
extension StoryPreviewPageViewController {
    private func configureNavigation(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnTap = false
            navigationController.hidesBarsOnSwipe = false
            
            navigationController.setNavigationBarHidden(false, animated: animated)
            
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
}

extension StoryPreviewPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if
            let storyPreviewViewController = viewController as? StoryPreviewViewController,
            let index = self.stories.firstIndex(where: { $0.id == storyPreviewViewController.story.id }),
            let story = self.stories[optional: index - 1]
        {
            return StoryPreviewViewController(story: story, userService: self.userService, imageService: self.imageService)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if
            let storyPreviewViewController = viewController as? StoryPreviewViewController,
            let index = self.stories.firstIndex(where: { $0.id == storyPreviewViewController.story.id }),
            let story = self.stories[optional: index + 1]
        {
            return StoryPreviewViewController(story: story, userService: self.userService, imageService: self.imageService)
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.stories.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.firstIndex
    }
}

// MARK: Selectors
extension StoryPreviewPageViewController {
    
}

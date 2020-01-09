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
    
    let stories: [BaseStory]
    let firstIndex: Int
    
    init(stories: [BaseStory], firstIndex: Int, userService: UserService = .shared, imageService: ImageService = .shared) {
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
        
        self.view.backgroundColor = .systemBackground
        
        if let baseStory = self.stories[optional: self.firstIndex] {
            let storyPreviewViewController = StoryPreviewViewController()
            storyPreviewViewController.set(baseStory)
            
            self.setViewControllers([storyPreviewViewController], direction: .forward, animated: false, completion: nil)
        }
        
        // Extend layout past navigation and tab bars
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top, .bottom]
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
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
}

extension StoryPreviewPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if
            let storyPreviewViewController = viewController as? StoryPreviewViewController,
            let index = self.stories.firstIndex(where: { $0.id == storyPreviewViewController.story?.id }),
            let baseStory = self.stories[optional: index - 1]
        {
            let storyPreviewViewController = StoryPreviewViewController()
            storyPreviewViewController.set(baseStory)
            
            return storyPreviewViewController
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if
            let storyPreviewViewController = viewController as? StoryPreviewViewController,
            let index = self.stories.firstIndex(where: { $0.id == storyPreviewViewController.story?.id }),
            let baseStory = self.stories[optional: index + 1]
        {
            let storyPreviewViewController = StoryPreviewViewController()
            storyPreviewViewController.set(baseStory)
            
            return storyPreviewViewController
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

//
//  AppDelegate.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configure Firebase
        FirebaseApp.configure()
        
        // Configure Services
        StoryService.shared.configure()
        UserService.shared.configure()
        ImageService.shared.configure()
        GenreService.shared.configure()
        
        // Configure Managers
        SettingsManager.shared.configure()
        
        self.configureNavigationBarAppearance()
        self.configureToolbarAppearance()
        self.configureTabBarAppearance()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func configureNavigationBarAppearance() {
        let standard = UINavigationBarAppearance()
        standard.configureWithDefaultBackground()
        standard.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        standard.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        standard.shadowColor = UIColor(named: "Empty")
        standard.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        standard.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 34, weight: .heavy)]
        
        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.configureWithTransparentBackground()
        scrollEdge.backgroundColor = .clear
        scrollEdge.backgroundEffect = nil
        scrollEdge.shadowColor = nil
        scrollEdge.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        scrollEdge.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 34, weight: .heavy)]
        
        
        UINavigationBar.appearance().standardAppearance = standard
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdge
    }
    
    private func configureToolbarAppearance() {
        let standard = UIToolbarAppearance()
        standard.configureWithDefaultBackground()
        standard.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        standard.backgroundColor = UIColor(named: "Background")?.withAlphaComponent(0.5)
        standard.shadowColor = UIColor(named: "Empty")
        
        UIToolbar.appearance().standardAppearance = standard
        UIToolbar.appearance().compactAppearance = standard
    }
    
    private func configureTabBarAppearance() {
        let stacked = UITabBarItemAppearance(style: .stacked)
        stacked.selected.iconColor = UIColor(named: "Primary")
        stacked.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Primary") ?? .systemRed]
        stacked.normal.iconColor = UIColor(named: "Subtext")
        stacked.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Subtext") ?? UIColor.secondaryLabel]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        appearance.backgroundColor = UIColor(named: "Background")?.withAlphaComponent(0.5)
        appearance.shadowColor = UIColor(named: "Empty")
        appearance.stackedLayoutAppearance = stacked
        appearance.compactInlineLayoutAppearance = stacked
        appearance.inlineLayoutAppearance = stacked
        
        UITabBar.appearance().standardAppearance = appearance
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Miscellany")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


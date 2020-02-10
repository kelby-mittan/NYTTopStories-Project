//
//  TopStoriesTabController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import DataPersistence

class TopStoriesTabController: UITabBarController {
    
    public var dataPersistence = DataPersistence<Article>(filename: "savedArticles.plist")
    
    private lazy var newsFeedVC: NewsFeedViewController = {
        let viewController = NewsFeedViewController()
        viewController.dataPersistence = dataPersistence
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticleViewController = {
       let viewController = SavedArticleViewController()
        viewController.dataPersistence = dataPersistence
        viewController.dataPersistence.delegate = viewController
        viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
        return viewController
    }()
    
    private lazy var settingsVC: SettingsViewController = {
       let viewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeedVC.dataPersistence = dataPersistence
//        savedArticlesVC.dataPersistence = dataPersistence
        
        viewControllers = [UINavigationController(rootViewController: newsFeedVC), UINavigationController(rootViewController: savedArticlesVC), UINavigationController(rootViewController: settingsVC)]
    }
    
    
}

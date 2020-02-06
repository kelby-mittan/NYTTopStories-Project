//
//  TopStoriesTabController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class TopStoriesTabController: UITabBarController {
    
    private lazy var newsFeedVC: NewsFeedViewController = {
       let viewController = NewsFeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticleViewController = {
       let viewController = SavedArticleViewController()
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
        
        viewControllers = [newsFeedVC, savedArticlesVC, settingsVC]
    }
    
    
}

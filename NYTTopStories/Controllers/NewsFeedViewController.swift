//
//  NewsFeedViewController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedViewController: UIViewController {

    private let newsFeedView = NewsFeedView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
            }
        }
    }
    
    private var sectionName = "Technology" {
        didSet {
            // TODO:
        }
    }
    
    override func loadView() {
        view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsFeedView.collectionView.dataSource = self
        newsFeedView.collectionView.delegate = self
        
        newsFeedView.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "articleCell")
        
        view.backgroundColor = .systemBackground
        fetchStories()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchStories()
    }
    

    private func fetchStories(for section: String = "Technology") {
        
        if let sectionName = UserDefaults.standard.object(forKey: RecentCategoryKey.category) as? String {
            
            if sectionName != self.sectionName {
                queryAPI(for: sectionName)
                self.sectionName = sectionName
            }
        } else {
            // use the default section name
            queryAPI(for: sectionName)
        }
        
    }
    
    private func queryAPI(for section: String) {
        NYTAPIClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let articles):
                dump(articles)
                self?.newsArticles = articles
            }
        }
    }
    

}

extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell else {
            fatalError("could not deque cell")
        }
        let article = newsArticles[indexPath.row]
        
        cell.backgroundColor = .systemBackground
        cell.configureCell(with: article)
        return cell
    }
    
    
}

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.9
        let itemHeight: CGFloat = maxSize.height * 0.30
        
        return CGSize(width: itemWidth, height: itemHeight * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let article = newsArticles[indexPath.row]
        let articleDetailVC = ArticleDetailViewController()
        
        // TODO: after assessment we will be using initialzers as dependency injection mechanisms
        
        articleDetailVC.article = article
        articleDetailVC.dataPersistence = dataPersistence
        
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }
    
    
}

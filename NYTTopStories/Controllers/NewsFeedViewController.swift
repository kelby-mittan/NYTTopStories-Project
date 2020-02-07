//
//  NewsFeedViewController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    private let newsFeedView = NewsFeedView()
    
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
    

    private func fetchStories() {
        NYTAPIClient.fetchTopStories(for: "Technology") { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let articles):
                dump(articles)
            }
        }
    }
    

}

extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath)
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    
}

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

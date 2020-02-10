//
//  SavedArticleViewController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticleViewController: UIViewController {
    
    private let savedArticleView = SavedArticleView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    // TODO: create a SavedArticleView
    // TODO: add a collection view to the SavedArticleView
    // TODO: collection view is vertical with 2 cells per row
    // TODO: add SavedArticleView to SavedArticleViewController
    // TODO: create an array of savedArticle = [Article]
    // TODO: reload collection view in didSet of savedArticle array
    
    private var savedArticles = [Article]() {
        didSet {
            savedArticleView.collectionView.reloadData()
            if savedArticles.isEmpty {
                savedArticleView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles. Start browsing by tapping on the News Icon.")
            } else {
                savedArticleView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = savedArticleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataPersistence.delegate = self
        savedArticleView.collectionView.dataSource = self
        savedArticleView.collectionView.delegate = self
        
        savedArticleView.collectionView.register(SavedArticleCell.self, forCellWithReuseIdentifier: "savedArticle")
        fetchSavedArticles()
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        } catch {
            print("error fetching articles: \(error)")
        }
    }
    
    
    
}

extension SavedArticleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticle", for: indexPath) as? SavedArticleCell else {
            fatalError("could not deque")
        }
        let article = savedArticles[indexPath.row]
        
        // custom delegate step 4:
        cell.delegate = self
        
        cell.configureCell(for: article)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
    
}

extension SavedArticleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.3
        let numberOfItems: CGFloat = 2
        let spacing: CGFloat = 10
        let totalSpacing: CGFloat = ((2 * spacing) + (numberOfItems - 1)) * numberOfItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // programatically setup a segue
        let detailArticleVC = ArticleDetailViewController()
        let article = savedArticles[indexPath.row]
        
        detailArticleVC.dataPersistence = dataPersistence
        detailArticleVC.article = article
        navigationController?.pushViewController(detailArticleVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension SavedArticleViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
    
}

// custom delegate step 5:

extension SavedArticleViewController: SavedArticleCellDelegate {
    
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article) {
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteArticle(article)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteArticle(_ article: Article) {
        guard let index = savedArticles.firstIndex(of: article) else {
            return
        }
        do {
            try self.dataPersistence.deleteItem(at: index)
        } catch {
            print("could not delete item")
        }
    }
}

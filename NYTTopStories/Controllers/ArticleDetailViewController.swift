//
//  ArticleDetailViewController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/7/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class ArticleDetailViewController: UIViewController {

    private let detailView = ArticleDetailView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    public var article: Article?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        updateUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }
    
    private func updateUI() {
        guard let article = article else {
            fatalError("did not load article")
        }
        
        
        navigationItem.title = article.title
        detailView.abstractHeadline.text = article.abstract
        let imageURL = article.getArticleURL(for: .superJumbon)
        
        detailView.articleImageView.getImage(with: imageURL) { [weak self](result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.detailView.articleImageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.articleImageView.image = image
                }
            }
        }

    }
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        guard let article = article else { return }
        
        do {
            try dataPersistence.createItem(article)
        } catch {
            print("error: \(error)")
        }
    }

}

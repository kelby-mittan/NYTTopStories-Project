//
//  ArticleCell.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/7/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import ImageKit

class ArticleCell: UICollectionViewCell {
    
    
    public lazy var articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .orange
        return iv
    }()
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article Title"
        return label
    }()
    
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract Headline"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageViewConstraints()
        setupTitleLabelConstraints()
        setupAbstractLabelConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(articleImageView)
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            articleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
            
            
        ])
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupAbstractLabelConstraints() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstractHeadline.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstractHeadline.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor),
            abstractHeadline.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8)
        ])
    }
    
    public func configureCell(with article: Article) {
        
        articleTitle.text = article.title
        abstractHeadline.text = article.abstract
        
        let thumbnail = article.getArticleURL(for: .thumbLarge)
        
        articleImageView.getImage(with: thumbnail) { [weak self](result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.articleImageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.articleImageView.image = image
                }
            }
        }
    }
}


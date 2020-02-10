//
//  SavedArticleCell.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/10/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

// custom delegate step 1:
protocol SavedArticleCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article)
}

class SavedArticleCell: UICollectionViewCell {
    
    // more button
    // article title
    // news image
    
    // custom delegate step 2:
    weak var delegate: SavedArticleCellDelegate?
    
    private var currentArticle: Article!
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 5
        label.text = "Testing the title for the article"
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
        setupMoreButtonConstraints()
        setupArticleTitleConstraints()
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        print("button pressed for \(currentArticle.title)")
        
        // custom delegate step 3:
        delegate?.didSelectMoreButton(self, article: currentArticle)
        
    }
    
    private func setupMoreButtonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupArticleTitleConstraints() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureCell(for article: Article) {
        
        articleTitle.text = article.title
        currentArticle = article
        
        
        
    }
    
    
    
}

//
//  ArticleDetailView.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/7/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {

    public lazy var articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        return iv
    }()
    
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract Headline"
        return label
    }()
    
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "By line"
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
        setupAbstractLabelConstraint()
    }
    
    private func setupImageViewConstraints() {
        addSubview(articleImageView)
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupAbstractLabelConstraint() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractHeadline.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
            abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abstractHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupByLineLabelConstraint() {
        addSubview(byLine)
        byLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            byLine.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
            byLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            byLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    

}

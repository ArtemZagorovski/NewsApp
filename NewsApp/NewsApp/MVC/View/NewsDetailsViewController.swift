//
//  NewsDatailsViewController.swift
//  NewsApp
//
//  Created by Артем  on 7/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    private var news: NewsViewModel?
    var controller: NewsDetailsViewDelegate?
    
    private let newsImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let publishedAtLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller?.viewDidLoad()
        setupView()
        setupLayout()
    }
}

extension NewsDetailsViewController {
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
        newsImageView.contentMode = .scaleAspectFill
        publishedAtLabel.textAlignment = .right
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupLayout() {
        let horizontalInsets: CGFloat = 10
        let topInset: CGFloat = 20
        let newsImageViewTopInset: CGFloat = 100
        
        let newsImageViewConstraints = [
            newsImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: newsImageViewTopInset),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInsets),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalInsets),
            newsImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ]
        let publishedAtLabelConstraints = [
            publishedAtLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: topInset),
            publishedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInsets),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalInsets)
        ]
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: topInset),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInsets),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalInsets)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topInset),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalInsets),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalInsets)
        ]
        
        view.addSubview(newsImageView)
        view.addSubview(publishedAtLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            newsImageViewConstraints
                + publishedAtLabelConstraints
                + titleLabelConstraints
                + descriptionLabelConstraints
        )
    }
}

extension NewsDetailsViewController: NewsDetailsView {
    func updateView(_ news: NewsViewModel) {
        self.news = news
        newsImageView.image = news.image
        publishedAtLabel.text = news.publishedAt
        titleLabel.text = news.newsTitle
        descriptionLabel.text = news.newsDescription
    }
}

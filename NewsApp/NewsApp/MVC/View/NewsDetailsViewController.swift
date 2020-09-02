//
//  NewsDatailsViewController.swift
//  NewsApp
//
//  Created by Артем  on 7/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var news: News!
    
    private let newsImage = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let publishedAt = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
}

extension NewsDetailsViewController{
    
    private func setupView() {
        view.backgroundColor = Constants.AppColors.white
        
        if let newsImageData = news.imageData {
            guard let image = UIImage(data: newsImageData) else { return }
            newsImage.image = image
        } else {
            newsImage.image = UIImage(named: "news")
        }
        newsImage.layer.cornerRadius = 10
        newsImage.clipsToBounds = true
        newsImage.contentMode = .scaleAspectFill
        
        publishedAt.text = news.publishedAt
        publishedAt.textAlignment = .right
        
        titleLabel.text = news.newsTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.text = news.newsDescription
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupLayout() {
        view.addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsImage.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
        
        view.addSubview(publishedAt)
        publishedAt.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            publishedAt.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            publishedAt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            publishedAt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: publishedAt.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
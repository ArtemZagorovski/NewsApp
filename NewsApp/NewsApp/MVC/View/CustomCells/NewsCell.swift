//
//  NewsCell.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var news : News? {
        didSet {
            guard let news = news else {
                return
            }
            
            if let imageData = news.imageData, let image = UIImage(data: imageData) {
                newsImage.image = image
            }
            titleLabel.text = news.newsTitle
            descriptionLabel.text = news.newsDescription
            
            DispatchQueue.main.async {
                if self.descriptionLabel.actualNumberOfLines() > 3 {
                    self.showMoreLabel.isHidden = false
                } else {
                    self.showMoreLabel.isHidden = true
                }
            }
        }
        
    }
    
    private let newsImage : UIImageView = {
        let imageName = Constants.SystemWords.defaultImageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.italicSystemFont(ofSize: 12.0)
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private let showMoreLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.SystemWords.textShowMore
        lbl.textColor = .systemBlue
        lbl.textAlignment = .right
        lbl.font = UIFont.italicSystemFont(ofSize: 12.0)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStack.axis = .vertical
        textStack.alignment = .top
        textStack.distribution = .fill
        textStack.spacing = 5
        
        addSubview(textStack)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            newsImage.heightAnchor.constraint(equalToConstant: 80),
            newsImage.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 10),
            textStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ])
        
        insertSubview(showMoreLabel, aboveSubview: textStack)
        showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showMoreLabel.trailingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: 0),
            showMoreLabel.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 1)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


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
            var text = news.newsDescription
            if text.count > 180 {
                text.removeLast(text.count - 180)
                let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 11.0)
                let readmoreFontColor = UIColor.blue
                DispatchQueue.main.async {
                    self.descriptionLabel.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
                }
            }
            descriptionLabel.text = text
        }
        
    }
    
    private let newsImage : UIImageView = {
        let imageName = "news"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Title"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "description"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.italicSystemFont(ofSize: 10.0)
        lbl.numberOfLines = 3

        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            textStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


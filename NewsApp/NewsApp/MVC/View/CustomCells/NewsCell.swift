//
//  NewsCell.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol NewsCellDelegate: class {
    func didTapFavouriteButton(cell: UITableViewCell)
}

final class NewsCell: UITableViewCell {
    
    weak var delegate: NewsCellDelegate?
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        let notFillImage = Constants.SystemWords.flameImageName
        let image = UIImage(systemName: notFillImage)?.withTintColor(.black)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let newsImageView : UIImageView = {
        let imageName = Constants.SystemWords.defaultImageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
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
        
        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStack.axis = .vertical
        textStack.alignment = .top
        textStack.distribution = .fill
        textStack.spacing = 5
        
        addSubview(newsImageView)
        addSubview(textStack)
        insertSubview(showMoreLabel, aboveSubview: textStack)
        addSubview(favouriteButton)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.addTarget(self, action: #selector(didTapFavouriteButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            newsImageView.heightAnchor.constraint(equalToConstant: 80),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            textStack.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
            textStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10),
            showMoreLabel.trailingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: 0),
            showMoreLabel.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 1),
            favouriteButton.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: 5),
            favouriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            favouriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func didTapFavouriteButton() {
        delegate?.didTapFavouriteButton(cell: self)
    }
    
    func configure(with viewModel: NewsViewModel, delegate: NewsCellDelegate) {
        self.delegate = delegate
        titleLabel.text = viewModel.newsTitle
        descriptionLabel.text = viewModel.newsDescription
        newsImageView.image = viewModel.image
        
        if viewModel.isFavourite {
            self.favouriteButton.setImage(UIImage(systemName: Constants.SystemWords.fillFlameImageName), for: .normal)
        }
        DispatchQueue.main.async {
            if self.descriptionLabel.actualNumberOfLines() > 3 {
                self.showMoreLabel.isHidden = false
            } else {
                self.showMoreLabel.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showMoreLabel.isHidden = true
        favouriteButton.setImage(UIImage(systemName: Constants.SystemWords.flameImageName), for: .normal)
    }
}

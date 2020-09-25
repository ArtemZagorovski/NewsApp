//
//  NewsCell.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol NewsCellDelegate: class {
    func didTapFavoriteButton(cell: UITableViewCell)
}

final class NewsCell: UITableViewCell {
    weak var delegate: NewsCellDelegate?
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let notFillImage = Constants.SystemWords.flameImageName
        let image = UIImage(systemName: notFillImage.rawValue)?.withTintColor(.black)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let newsImageView: UIImageView = {
        let imageName = Constants.SystemWords.defaultImageName
        let image = UIImage(named: imageName.rawValue)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 14.0)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.italicSystemFont(ofSize: 12.0)
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private let showMoreLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.SystemWords.textShowMore.rawValue
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
        let inset: CGFloat = 10
        let squareImageSide: CGFloat = 80
        let stackTopInset: CGFloat = 8
        let stackTrailingInset: CGFloat = 50
        let buttonHorizontalInsets: CGFloat = 5
        let buttonVerticalInsets: CGFloat = 30
        let rightInsetOfShowMore: CGFloat = 0
        let minimumButtonInset: CGFloat = 1
        let newsImangeViewConstraints = [
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            newsImageView.heightAnchor.constraint(equalToConstant: squareImageSide),
            newsImageView.widthAnchor.constraint(equalToConstant: squareImageSide)
        ]
        let textStackConstraints = [
            textStack.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: inset),
            textStack.topAnchor.constraint(equalTo: self.topAnchor, constant: stackTopInset),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -stackTrailingInset),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -inset)
        ]
        let showMoreLabelConstraints = [
            showMoreLabel.trailingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: rightInsetOfShowMore),
            showMoreLabel.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: minimumButtonInset)
        ]
        let favoriteButtonConstraints = [
            favoriteButton.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: buttonHorizontalInsets),
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: buttonVerticalInsets),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -buttonHorizontalInsets),
            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -buttonVerticalInsets)
        ]
 
        textStack.axis = .vertical
        textStack.alignment = .top
        textStack.distribution = .fill
        textStack.spacing = 5
        
        addSubview(newsImageView)
        addSubview(textStack)
        insertSubview(showMoreLabel, aboveSubview: textStack)
        addSubview(favoriteButton)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)

        NSLayoutConstraint.activate(
            newsImangeViewConstraints
                + textStackConstraints
                + showMoreLabelConstraints
                + favoriteButtonConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton(cell: self)
    }
    
    func configure(with viewModel: NewsViewModel, delegate: NewsCellDelegate) {
        self.delegate = delegate
        titleLabel.text = viewModel.newsTitle
        descriptionLabel.text = viewModel.newsDescription
        newsImageView.image = viewModel.image
        
        if viewModel.isFavorite {
            favoriteButton.setImage(UIImage(systemName: Constants.SystemWords.fillFlameImageName.rawValue), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: Constants.SystemWords.flameImageName.rawValue), for: .normal)
        }
        let hasMoreText = descriptionLabel.actualNumberOfLines() > 3
        showMoreLabel.isHidden = !hasMoreText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showMoreLabel.isHidden = true
    }
}

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
        let inset: CGFloat = 10
        let squareImageSide: CGFloat = 80
        let stackTopInset: CGFloat = 8
        let stackTrailingInset: CGFloat = 50
        let buttonHorizontalInsets: CGFloat = 5
        let buttonVerticalInsets: CGFloat = 30
        let zero: CGFloat = 0
        let one: CGFloat = 1
        let newsImangeViewConstraints = [
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            newsImageView.heightAnchor.constraint(equalToConstant: squareImageSide),
            newsImageView.widthAnchor.constraint(equalToConstant: squareImageSide)]
        let textStackConstraints = [
            textStack.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: inset),
            textStack.topAnchor.constraint(equalTo: self.topAnchor, constant: stackTopInset),
            textStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -stackTrailingInset),
            textStack.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -inset)]
        let showMoreLabelConstraints = [
            showMoreLabel.trailingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: zero),
            showMoreLabel.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: one)]
        let favoriteButtonConstraints = [
            favouriteButton.leadingAnchor.constraint(equalTo: textStack.trailingAnchor, constant: buttonHorizontalInsets),
            favouriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: buttonVerticalInsets),
            favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -buttonHorizontalInsets),
            favouriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -buttonVerticalInsets)]
 
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

        NSLayoutConstraint.activate(newsImangeViewConstraints + textStackConstraints + showMoreLabelConstraints + favoriteButtonConstraints)
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
        let hasMoreText = self.descriptionLabel.actualNumberOfLines() > 3
        showMoreLabel.isHidden = !hasMoreText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showMoreLabel.isHidden = true
        favouriteButton.setImage(UIImage(systemName: Constants.SystemWords.flameImageName), for: .normal)
    }
}

//
//  FavouriteNewsViewController.swift
//  NewsApp
//
//  Created by Zagorovsky, Artem on 9/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class FavouriteNewsViewController: UIViewController {
    private let tableView = UITableView()
    private var viewModels: [NewsViewModel] = []
    
    override func viewDidLoad() {
        setDelegates()
        setupView()
        setupLayout()
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
    
//MARK: - Setup view and layout
extension FavouriteNewsViewController {
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: Constants.NewsTable.favouriteNewsCellID)
        tableView.backgroundColor = Constants.AppColors.white
        view.backgroundColor = Constants.AppColors.white
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - UITableView delegate and datasource
extension FavouriteNewsViewController: UITableViewDelegate {}

extension FavouriteNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NewsTable.favouriteNewsCellID, for: indexPath) as? NewsCell else { return UITableViewCell()}
        let news = viewModels[indexPath.row]
        cell.news = news
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

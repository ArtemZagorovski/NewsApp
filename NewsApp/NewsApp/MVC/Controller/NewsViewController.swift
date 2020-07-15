//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }
    private let apiManager = APIManager()
    private var currentNews = [News]() {
        didSet{
            tableView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    private var totalNews: Int!
    private var countOfDays = 0
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "Search news"
        s.searchBar.sizeToFit()
        s.searchBar.searchBarStyle = .prominent
        s.searchBar.delegate = self
        return s
    }()
    
    var searchNews: [News?] = [News]()
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        navigationItem.searchController = searchController
        self.title = "News"
        
        getDataFromAPI()
        setupView()
        setupLayout()

    }
    
    func isFiltring() -> Bool {
        let searchbarScopeIsFiltring = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchbarScopeIsFiltring)
    }
    
    private func getDataFromAPI() {
        DispatchQueue.global().async {

            let date = Date().rewindDays(-self.countOfDays)
            let dateString = Formatter.getStringWithWeekDay(date: date)
            self.apiManager.getNews(dateString: dateString) {[unowned self] (result) in
                switch result {
                    
                case .Success(let news):
                    DispatchQueue.main.async {
                        if self.countOfDays == 0 {
                            self.currentNews = news.0
                        } else {
                            self.currentNews += news.0
                        }
                        
                        if self.countOfDays < 7 {
                            self.countOfDays += 1
                        }
                    }
                    self.totalNews = news.1
                case .Failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: - Setup layout and views
extension NewsViewController{
    
    private func setupView() {
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "New")
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.insertSubview(activityIndicator, aboveSubview: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            activityIndicator.heightAnchor.constraint(equalToConstant: 10),
            activityIndicator.widthAnchor.constraint(equalToConstant: 10),
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
    
}

//MARK: - TableView Delegate and Datasource
extension NewsViewController: UITableViewDelegate {
    
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltring() {
            return searchNews.count
        } else {
            return currentNews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "New", for: indexPath) as! NewsCell
        
        if isFiltring() {
            let news = searchNews[indexPath.row]
            cell.news = news
            return cell
        } else {
            let news = currentNews[indexPath.row]
            cell.news = news
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == currentNews.count - 1 {
            
            if currentNews.count < totalNews {
                getDataFromAPI()
                activityIndicator.startAnimating()
            }
        }
    }
}

//MARK: - SearchController Extension

extension NewsViewController: UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All")  {
        searchNews = currentNews.filter { (news: News?) -> Bool in
            guard let news = news else { return false }
            
            if isSearchBarEmpty {
                return true
            } else {
                return news.newsTitle.lowercased().contains(searchText.lowercased()) || news.newsDescription.lowercased().contains(searchText.lowercased())
            }
      }
      tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        filterContentForSearchText(searchBar.text!)
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

//MARK: - Actions
extension NewsViewController {
    @objc private func pullToRefresh(sender: UIRefreshControl) {
        countOfDays = 0
        getDataFromAPI()
        sender.endRefreshing()
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ViewsVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let signUpVC = NewsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ViewsVCProvider.ContainerView>) -> NewsViewController {
            return signUpVC
        }
        
        func updateUIViewController(_ uiViewController: ViewsVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ViewsVCProvider.ContainerView>) {
            
        }
    }
}

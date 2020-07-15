//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Артем  on 7/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift

class NewsViewController: UIViewController {
    
    private let tableView = UITableView()
    private let newPageLoadActivityIndicator = UIActivityIndicatorView(style: .medium)
    private let mainPageLoadActivityIndicator = UIActivityIndicatorView(style: .large)
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }
    private let apiManager = APIManager()

    private var newsFromDB: Results<News>! {
        didSet{
            
            tableView.reloadData()
            
            newPageLoadActivityIndicator.stopAnimating()
        }
    }
    
    private var totalNews = 140
    private var countOfDays = 0
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "News"
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
        
        newsFromDB = realm.objects(News.self)
        countOfDays = newsFromDB.count / 20
        getDataFromRealm()
        
        setupView()
        setupLayout()
    }
    
    func isFiltring() -> Bool {
        let searchbarScopeIsFiltring = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchbarScopeIsFiltring)
    }
    
    private func getDataFromRealm() {
        
        if newsFromDB.count == 0 {
            mainPageLoadActivityIndicator.startAnimating()
            getDataFromAPI()
        }
        newsFromDB = realm.objects(News.self)
    }
    
    private func getDataFromAPI() {
        

            let date = Date().rewindDays(-self.countOfDays)
            let dateString = Formatter.getStringWithWeekDay(date: date)
            self.apiManager.getNews(dateString: dateString) {[unowned self] (result) in
                switch result {
                    
                case .Success(let totalNews):
                    DispatchQueue.main.async {
                        if self.countOfDays == 0 {
                            totalNews.0.forEach { (news) in
                                StorageManager.saveNews(news)
                            }
                            self.mainPageLoadActivityIndicator.stopAnimating()
                        }
                        
                        self.countOfDays += 1
                        self.getDataFromRealm()
                    }
                    self.totalNews = totalNews.1
                case .Failure(let error):
                    print(error)
                }
            
        }
    }
}

//MARK: - Setup layout and views
extension NewsViewController{
    
    private func setupView() {
        self.title = "News searching..."
        mainPageLoadActivityIndicator.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        mainPageLoadActivityIndicator.layer.cornerRadius = 5
        tableView.register(NewsCell.self, forCellReuseIdentifier: "New")
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.insertSubview(mainPageLoadActivityIndicator, aboveSubview: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainPageLoadActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            mainPageLoadActivityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            mainPageLoadActivityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            newPageLoadActivityIndicator.heightAnchor.constraint(equalToConstant: 30),
            newPageLoadActivityIndicator.widthAnchor.constraint(equalToConstant: 30)
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
            return newsFromDB.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "New", for: indexPath) as! NewsCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        if isFiltring() {
            let news = searchNews[indexPath.row]
            cell.news = news
            return cell
        } else {
            let news = newsFromDB[indexPath.row]
            cell.news = news
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsFromDB.count - 1 {
            
            if newsFromDB.count < totalNews && countOfDays < 7 {
                getDataFromAPI()
            }
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && !isFiltring() && countOfDays < 7 {
            newPageLoadActivityIndicator.startAnimating()
            newPageLoadActivityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = newPageLoadActivityIndicator
            self.tableView.tableFooterView?.isHidden = false
        }
    }
}

//MARK: - SearchController Extension

extension NewsViewController: UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String)  {
        searchNews = newsFromDB.filter { (news: News?) -> Bool in
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
    func searchBar(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: - Actions
extension NewsViewController {
    @objc private func pullToRefresh(sender: UIRefreshControl) {
        countOfDays = 0
        newsFromDB.forEach { (news) in
            StorageManager.deliteNews(news)
        }
        getDataFromRealm()
        mainPageLoadActivityIndicator.startAnimating()
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

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
    
//MARK: - Variables and constatns
    private let tableView = UITableView()
    private let newPageLoadActivityIndicator = UIActivityIndicatorView(style: .medium)
    private let mainPageLoadActivityIndicator = UIActivityIndicatorView(style: .large)
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = Constants.SystemWords.searchNews
        s.searchBar.sizeToFit()
        s.searchBar.searchBarStyle = .prominent
        s.searchBar.delegate = self
        return s
    }()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private let apiService = APIService()
    private var searchNews: [News] = []
    private var viewNews: [News] = []
    private var page = 1
    private var totalPages = 1
    
//MARK: - ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegats()
        apiService.getNewsTotalNumber()
        loadData()
        animateActivity()
        countOfDays()
        addObservers()
        setupView()
        setupLayout()
    }
    
//MARK: - Private Methods
    fileprivate func setDelegats() {
        tableView.delegate = self
        tableView.dataSource = self
        apiService.delegate = self
    }
    
    private func loadData() {
        if page <= totalPages {
            apiService.getData(page: page)
            page += 1
        }

    }
    
    fileprivate func countOfDays() {
        Constants.Logic.countOfDays = DBDataLoader.newsFromDB != nil ? DBDataLoader.newsFromDB.count / 18 : 0
    }
    
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdate), name: NSNotification.Name(rawValue: Constants.NotificationNames.newData), object: nil)
    }
    
    fileprivate func animateActivity() {
        
        mainPageLoadActivityIndicator.startAnimating()
        
    }
}

//MARK: - Setup layout and views
extension NewsViewController{
    
    private func setupView() {
        self.title = Constants.SystemWords.news
        navigationItem.searchController = searchController
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        tableView.register(NewsCell.self, forCellReuseIdentifier: Constants.NewsTable.newsCellID)
        tableView.backgroundColor = Constants.AppColors.white
        view.backgroundColor = Constants.AppColors.white
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
            mainPageLoadActivityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
    
}

//MARK: - TableView Delegate and Datasource
extension NewsViewController: UITableViewDelegate {}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltring() ? searchNews.count : viewNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NewsTable.newsCellID, for: indexPath) as! NewsCell
        
        let news = isFiltring() ? searchNews[indexPath.row] : viewNews[indexPath.row]
        cell.news = news
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = NewsDetailsViewController()
        let news = isFiltring() ? searchNews[indexPath.row] : viewNews[indexPath.row]
        detailViewController.news = news
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let isNeedToLoadNewData = indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && !searchController.isActive && viewNews.count < totalPages
        if isNeedToLoadNewData {
            newPageLoadActivityIndicator.startAnimating()
            newPageLoadActivityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = newPageLoadActivityIndicator
            self.tableView.tableFooterView?.isHidden = false
            loadData()
        }
    }
}

//MARK: - SearchController Extension
extension NewsViewController: UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String)  {
        searchNews = viewNews.filter { (news: News?) -> Bool in
            guard let news = news else { return false }
            
            return isSearchBarEmpty ? true : (news.newsTitle.lowercased().contains(searchText.lowercased()) || news.newsDescription.lowercased().contains(searchText.lowercased()))
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func isFiltring() -> Bool {
        let searchbarScopeIsFiltring = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchbarScopeIsFiltring)
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
        page = 1
        loadData()
    }
    
    @objc func didUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.mainPageLoadActivityIndicator.stopAnimating()
            if self.tableView.numberOfRows(inSection: 0) > 1 {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension NewsViewController: NewsServiceDelegate {
    
    func didLoadData(_ news: [News]) {
        viewNews += news
        DispatchQueue.main.async {
            self.mainPageLoadActivityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func didGetAnError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func didGetTotalNews(total: Int) {
        totalPages = total / 20
    }
    
}

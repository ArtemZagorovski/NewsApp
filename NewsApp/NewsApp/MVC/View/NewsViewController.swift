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
    private let emptyStateLabel = UILabel()
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

    var viewModels: [NewsViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.emptyStateLabel.isHidden = !self.viewModels.isEmpty
            }
        }
    }
    var delegate: NewsViewDelegate?
    
//MARK: - ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegats()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.viewWillAppear()
    }

//MARK: - Private Methods
    fileprivate func setDelegats() {
        tableView.delegate = self
        tableView.dataSource = self
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
        emptyStateLabel.text = "There are no news"
        emptyStateLabel.isHidden = true
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(mainPageLoadActivityIndicator)
        view.addSubview(emptyStateLabel)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainPageLoadActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            mainPageLoadActivityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            mainPageLoadActivityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            emptyStateLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
}

//MARK: - TableView Delegate and Datasource
extension NewsViewController: UITableViewDelegate {}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NewsTable.newsCellID, for: indexPath) as! NewsCell
        let news = viewModels[indexPath.row]
        cell.configure(with: news, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = viewModels[indexPath.row]
        delegate?.viewDidTapCell(for: news)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let isLastSection = indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex
        guard let isLoadMoreAvailable = delegate?.isLoadMoreDataAvailable() else { return }
        let isNeedToLoadNewData = isLastSection && !searchController.isActive && isLoadMoreAvailable
        if isNeedToLoadNewData {
            newPageLoadActivityIndicator.startAnimating()
            newPageLoadActivityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = newPageLoadActivityIndicator
            self.tableView.tableFooterView?.isHidden = false
            delegate?.viewDidScrollToEnd()
        }
    }
}

//MARK: - SearchController Extension
extension NewsViewController: UISearchResultsUpdating {
    func filterContentForSearchText(_ searchText: String)  {
        delegate?.viewDidChangeSearchTerm(searchText)
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
        guard let isPullToRefreshAvailable = delegate?.isPullToRefreshAvaliable() else { return }
        if isPullToRefreshAvailable {
            delegate?.viewDidPullToRefresh()
        } else {
            sender.endRefreshing()
        }
        
    }
}

extension NewsViewController: NewsView {
    func updateView(_ news: [NewsViewModel]) {
        viewModels = news
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.mainPageLoadActivityIndicator.stopAnimating()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func animateActivity() {
        mainPageLoadActivityIndicator.startAnimating()
    }
}

extension NewsViewController: NewsCellDelegate {
    func didTapFavoriteButton(cell: UITableViewCell) {
        guard let indexOfCell = tableView.indexPath(for: cell) else { return }
        delegate?.viewDidTapFavoriteButton(for: viewModels[indexOfCell.row], currentFavoriteState: viewModels[indexOfCell.row].isFavorite) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if self.delegate?.isFavoriteViewController ?? false {
                    self.viewModels.remove(at: indexOfCell.row)
                    self.tableView.deleteRows(at: [indexOfCell], with: .top)
                }
                else {
                    self.viewModels[indexOfCell.row].isFavorite = !(self.viewModels[indexOfCell.row].isFavorite)
                    self.tableView.reloadRows(at: [indexOfCell], with: .none)
                }
            }
        }
    }
}

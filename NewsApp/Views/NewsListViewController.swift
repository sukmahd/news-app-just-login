//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 07/12/24.
//

import Foundation
import UIKit
import SnapKit

class NewsListViewController: UIViewController {
    private let viewModel: NewsListViewModel
    
    let defaultIdentifier = "defaultIdentifier"
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        viewModel.fetchNews()
    }
    
    private func setupUI() {
        title = "News"
        view.backgroundColor = .white
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }

    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func showError(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate & Data Source
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else {
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: defaultIdentifier, for: indexPath)
            return defaultCell
        }
        if let article = viewModel.getArticle(at: indexPath.row) {
            cell.configCell(with: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedNews = viewModel.getArticle(at: indexPath.row) else {
            showError(with: "Article Not Found")
            return
        }

        navigationController?.pushViewController(NewsListDetailViewController(viewModel: NewsDetailViewModel(article: selectedNews)), animated: true)
    }
}

//MARK: - viewModel Delegate
extension NewsListViewController: NewsListViewModelDelegate {
    func didUpdateData() {
        tableView.reloadData()
    }
    
    func didError(error: String) {
        showError(with: error)
    }
}

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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }

    private func setupViewModel() {
        viewModel.delegate = self
    }
}

// MARK: - TableView Delegate & Data Source
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsListTableViewCell
        if let article = viewModel.getArticle(at: indexPath.row) {
            cell.configCell(with: article)
        }
        return cell
    }
}

//MARK: - viewModel Delegate
extension NewsListViewController: NewsListViewModelDelegate {
    func didUpdateData() {
        tableView.reloadData()
    }
    
    func didError(error: String) {
        //todo: Show Error
    }
}

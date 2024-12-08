//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 07/12/24.
//

import Foundation

protocol NewsListViewModelDelegate: AnyObject {
    func didUpdateData()
    func didError(error: String)
}

class NewsListViewModel {
    // MARK: - Properties
    private var articles: [NewsArticle] = []
    private let serviceProvider: NewsServiceProtocol
    weak var delegate: NewsListViewModelDelegate?
    
    init(serviceProvider: NewsServiceProtocol, delegate: NewsListViewModelDelegate? = nil) {
        self.serviceProvider = serviceProvider
        self.delegate = delegate
    }
    
    var numberOfArticles: Int {
        return articles.count
    }
    
    func getArticle(at index: Int) -> NewsArticle? {
        guard index < articles.count else { return nil }
        return articles[index]
    }
    
    func fetchNews() {
        serviceProvider.getNewsArticle { [weak self] result in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self?.articles = articles
                    self?.delegate?.didUpdateData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.didError(error: error.localizedDescription)
                }
            }
        }
    }
}

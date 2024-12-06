//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 07/12/24.
//

import Foundation

class NewsListViewModel {
    // MARK: - Properties
    private var articles: [NewsArticle] = []
    
    var numberOfArticles: Int {
        return articles.count
    }
    
    func getArticle(at index: Int) -> NewsArticle? {
        guard index < articles.count else { return nil }
        return articles[index]
    }
    
    func fetchNews() {
        
    }
}

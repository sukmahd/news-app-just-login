//
//  NewsServiceProtocol.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import Foundation

protocol NewsServiceProtocol {
    func getNewsArticle(completion: @escaping (Result<[NewsArticle], Error>) -> Void)
}

class NewsService: NewsServiceProtocol {
    func getNewsArticle(completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.org/posts")
        
        NetworkManager.shared.request(url: url, expecting: [NewsArticle].self) { result in
            completion(result)
        }
    }
}

//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import Foundation

class NewsDetailViewModel {
    private var article: NewsArticle
    
    init(article: NewsArticle) {
        self.article = article
    }
    
    func getTitle() -> String {
        return article.slug
    }
    
    func getHeadline() -> String {
        return article.title
    }
    
    func getPublishedDate() -> String {
        return article.publishedAt
    }
    
    func getContent() -> String {
        return article.content
    }
    
    func getImageUrl() -> URL? {
        return URL(string: article.image)
    }
}

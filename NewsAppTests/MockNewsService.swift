//
//  MockNewsService.swift
//  NewsAppTests
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import Foundation
@testable import NewsApp

// Mock NewsServiceProtocol to simulate API behavior
class MockNewsService: NewsServiceProtocol {
    var shouldReturnError = false
    var mockArticles: [NewsArticle] = []

    func getNewsArticle(completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(MockError.mockError))
        } else {
            completion(.success(mockArticles))
        }
    }

    enum MockError: Error {
        case mockError
        
        var errorDescription: String? {
            return "Mock error occurred"
        }
    }
}

//
//  TestNewsListViewModel.swift
//  NewsAppTests
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import XCTest
@testable import NewsApp

import XCTest
@testable import NewsApp

class NewsListViewModelTests: XCTestCase {
    var viewModel: NewsListViewModel!
    var mockService: MockNewsService!
    var mockDelegate: MockNewsListViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
        mockDelegate = MockNewsListViewModelDelegate()
        viewModel = NewsListViewModel(serviceProvider: mockService, delegate: mockDelegate)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchNewsSuccess() {
        // Arrange
        let sampleArticles = [
            NewsArticle(
                id: 1,
                slug: "article-1",
                url: "https://example.com/article-1",
                title: "Article 1",
                content: "Content of Article 1",
                image: "https://example.com/image-1.jpg",
                thumbnail: "https://example.com/thumb-1.jpg",
                status: "published",
                category: "Tech",
                publishedAt: "2024-12-07T10:00:00Z",
                updatedAt: "2024-12-08T10:00:00Z",
                userId: 1
            ),
            NewsArticle(
                id: 2,
                slug: "article-2",
                url: "https://example.com/article-2",
                title: "Article 2",
                content: "Content of Article 2",
                image: "https://example.com/image-2.jpg",
                thumbnail: "https://example.com/thumb-2.jpg",
                status: "draft",
                category: "Science",
                publishedAt: "2024-12-06T10:00:00Z",
                updatedAt: "2024-12-07T10:00:00Z",
                userId: 2
            )
        ]
        mockService.mockArticles = sampleArticles
        mockService.shouldReturnError = false

        let expectation = XCTestExpectation(description: "Delegate should be called")

        mockDelegate.didUpdateDataCalled = false
        mockDelegate.didErrorCalled = false

        // Act
        viewModel.fetchNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        // Assert
        XCTAssertEqual(viewModel.numberOfArticles, sampleArticles.count)
        XCTAssertTrue(mockDelegate.didUpdateDataCalled)
        XCTAssertFalse(mockDelegate.didErrorCalled)
    }

    func testFetchNewsFailure() {
        // Arrange
        mockService.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Delegate should be called on error")

        mockDelegate.didUpdateDataCalled = false
        mockDelegate.didErrorCalled = false

        // Act
        viewModel.fetchNews()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        // Assert
        XCTAssertEqual(viewModel.numberOfArticles, 0) // No articles should be present
        XCTAssertFalse(mockDelegate.didUpdateDataCalled) // Update data should not be called
        XCTAssertTrue(mockDelegate.didErrorCalled) // Error delegate should be called
    }

    func testGetArticleAtIndex() {
        // Arrange
        let sampleArticles = [
            NewsArticle(
                id: 1,
                slug: "article-1",
                url: "https://example.com/article-1",
                title: "Article 1",
                content: "Content of Article 1",
                image: "https://example.com/image-1.jpg",
                thumbnail: "https://example.com/thumb-1.jpg",
                status: "published",
                category: "Tech",
                publishedAt: "2024-12-07T10:00:00Z",
                updatedAt: "2024-12-08T10:00:00Z",
                userId: 1
            )
        ]
        mockService.mockArticles = sampleArticles
        mockService.shouldReturnError = false
        viewModel.fetchNews()

        // Wait for async update
        let expectation = XCTestExpectation(description: "Wait for articles to be set")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        // Act & Assert
        XCTAssertEqual(viewModel.getArticle(at: 0)?.title, "Article 1")
        XCTAssertNil(viewModel.getArticle(at: 1))
    }
}

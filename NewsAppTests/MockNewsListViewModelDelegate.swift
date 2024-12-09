//
//  MockNewsListViewModelDelegate.swift
//  NewsAppTests
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import Foundation
@testable import NewsApp

class MockNewsListViewModelDelegate: NewsListViewModelDelegate {
    var didUpdateDataCalled = false
    var didErrorCalled = false
    var errorMessage: String?

    func didUpdateData() {
        didUpdateDataCalled = true
    }

    func didError(error: String) {
        didErrorCalled = true
        errorMessage = error
    }
}

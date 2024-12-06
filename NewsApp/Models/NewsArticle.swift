//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 07/12/24.
//

import Foundation

struct NewsArticle: Codable {
    let id: Int
    let slug: String
    let url: URL
    let title: String
    let content: String
    let image: URL
    let thumbnail: URL
    let status: String
    let category: String
    let publishedAt: String
    let updatedAt: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case url
        case title
        case content
        case image
        case thumbnail
        case status
        case category
        case publishedAt = "publishedAt"
        case updatedAt = "updatedAt"
        case userId = "userId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.url = try container.decode(URL.self, forKey: .url)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.image = try container.decode(URL.self, forKey: .image)
        self.thumbnail = try container.decode(URL.self, forKey: .thumbnail)
        self.status = try container.decode(String.self, forKey: .status)
        self.category = try container.decode(String.self, forKey: .category)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.userId = try container.decode(Int.self, forKey: .userId)
    }
}

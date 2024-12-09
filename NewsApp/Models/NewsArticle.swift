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
    let url: String
    let title: String
    let content: String
    let image: String
    let thumbnail: String
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
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? "-"
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? "-"
        self.image = try container.decodeIfPresent(String.self, forKey: .image) ?? "-"
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? "-"
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? "-"
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? "-"
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? "-"
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? "-"
        self.userId = try container.decodeIfPresent(Int.self, forKey: .userId) ?? 0
    }
    
    init(
            id: Int,
            slug: String,
            url: String,
            title: String,
            content: String,
            image: String,
            thumbnail: String,
            status: String,
            category: String,
            publishedAt: String,
            updatedAt: String,
            userId: Int
        ) {
            self.id = id
            self.slug = slug
            self.url = url
            self.title = title
            self.content = content
            self.image = image
            self.thumbnail = thumbnail
            self.status = status
            self.category = category
            self.publishedAt = publishedAt
            self.updatedAt = updatedAt
            self.userId = userId
        }
}

//
//  User.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-04.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: String
    let bio: String?
    let followers: Int?
    let following: Int?
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarUrl = "avatar_url"
        case bio
        case followers
        case following
        case htmlUrl = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
        following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
    }
    
}

struct UserListResponse: Codable {
    let items: [User]
}

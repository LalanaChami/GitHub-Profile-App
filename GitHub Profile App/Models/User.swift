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
    let followers: Int
    let following: Int
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
}

struct UserListResponse: Codable {
    let items: [User]
}

//
//  GetConversationsDto.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI

struct GetConversationsDto: Codable, Identifiable, Hashable {
    let id, userID: Int
    let title, createdAt: String
    let messages: [Messages]
    
    enum CodingKeys: String, CodingKey {
            case id
            case userID = "user_id"
            case title
            case createdAt = "created_at"
            case messages
        }
}

struct Messages: Codable, Hashable {
    let promptUser: PromptUser
}

struct PromptUser: Codable, Hashable {
    let id: Int
    let createdAt, content: String
    let response: Response
    
    enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case content, response
        }
}

struct Response: Codable, Hashable {
    let id: Int
    let content: String
}

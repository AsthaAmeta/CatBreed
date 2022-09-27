//
//  Cat.swift
//  AllCats
//
//  Created by Astha Ameta on 15/09/22.
//
// https://api.thecatapi.com/v1/breeds?api_key=live_t9ToA2y7iZBE8xcc1YmnXHTvSwkcX6W6WrjLAKrIsIw0VHqMsgwakbC0IfPEsxqP

import Foundation

struct Cat: Codable {
    let id: String
    let name: String
    let image: Image?
    let wikipediaURL: String?
    let description: String
    let origin: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case image
        case wikipediaURL = "wikipedia_url"
        case description
        case origin
    }
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let width, height: Int
    let url: String
}

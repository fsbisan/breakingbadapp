//
//  Character.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation

struct Character: Decodable {
    let id: String?
    let name: String?
    let birthday: String?
    let occupation: [String]
    let img: URL?
    let status: String?
    let nickname: String?
    let appearance: [Int]?
    let portrayed: String?
    let category: String?
    let betterCallSaulAppearance: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name = "name"
        case birthday = "birthday"
        case occupation = "occupation"
        case img = "img"
        case status = "status"
        case nickname = "nickname"
        case appearance = "appearance"
        case portrayed = "portrayed"
        case category = "category"
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
}

enum Link: String {
    case breakingBadApi = "https://www.breakingbadapi.com/api"
    case characters = "https://www.breakingbadapi.com/api/characters"
    case episodes = "https://www.breakingbadapi.com/api/episodes"
    case quotes = "https://www.breakingbadapi.com/api/quotes"
}

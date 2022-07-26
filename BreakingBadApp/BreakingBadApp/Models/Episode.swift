//
//  Episode.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation

struct Episode: Decodable {
    let id: Int?
    let title: String?
    let season: Int?
    let episode: Int?
    let airDate: Date?
    let characters: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title = "name"
        case season = "birthday"
        case episode = "occupation"
        case airDate = "air_date"
        case characters = "status"
    }
}

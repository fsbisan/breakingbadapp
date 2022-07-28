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
    let season: String?
    let airDate: String?
    let characters: [String]?
    let episode: String?
    let series: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title = "title"
        case season = "season"
        case episode = "episode"
        case airDate = "air_date"
        case characters = "characters"
        case series = "series"
    }
}

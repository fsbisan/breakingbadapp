//
//  Quote.swift
//  BreakingBadApp
//
//  Created by Александр Макаров on 24.07.2022.
//

import Foundation

struct Quote: Decodable {
    let id: Int?
    let quote: String?
    let author: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case quote = "quote"
        case author = "author"
    }
}

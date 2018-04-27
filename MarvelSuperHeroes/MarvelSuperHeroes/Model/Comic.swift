//
//  Comic.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 27/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

struct Comic: Codable, HeroDetail {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case description
    }
    
    let id: Int
    let name: String
    let description: String?
}

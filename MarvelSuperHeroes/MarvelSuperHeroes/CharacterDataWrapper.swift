//
//  CharacterDataWrapper.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

struct CharacterDataWrapper: Codable {
    
    struct CharacterDataContainer: Codable {
        let results: [Hero]?
    }
    
    let code: Int
    let status: String
    let data: CharacterDataContainer?
}

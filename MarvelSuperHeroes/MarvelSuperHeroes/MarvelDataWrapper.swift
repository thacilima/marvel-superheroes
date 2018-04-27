//
//  MarvelDataWrapper.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

struct MarvelDataWrapper<T:Codable>: Codable {
    
    struct MarvelDataContainer<T:Codable>: Codable {
        let results: [T]?
    }
    
    let code: Int
    let status: String
    let data: MarvelDataContainer<T>?
}

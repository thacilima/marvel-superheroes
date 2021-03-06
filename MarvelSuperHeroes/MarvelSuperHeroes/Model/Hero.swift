//
//  Hero.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

struct Hero: Codable {
    
    struct RemoteImageDataWrapper: Codable {
        let path: String
        let imageExtension: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case imageExtension = "extension"
        }
    }
    
    let id: Int
    let name: String
    let thumbnail: RemoteImageDataWrapper
}

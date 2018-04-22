//
//  MarvelService.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 21/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

class MarvelService {
    func getHeroes(limit: Int, offset: Int) -> [Hero] {
        let heroList = [Hero(id: 1, name: "Batman", thumbnailPath: URL(string:"")), Hero(id: 2, name: "Flash", thumbnailPath: URL(string:"")), Hero(id: 3, name: "Dead Pool", thumbnailPath: URL(string:""))]
        let result = heroList[offset..<limit]
        return Array(result)
    }
}

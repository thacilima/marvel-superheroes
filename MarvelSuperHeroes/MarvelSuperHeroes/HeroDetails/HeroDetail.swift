//
//  HeroDetail.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 27/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

protocol HeroDetail {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
}

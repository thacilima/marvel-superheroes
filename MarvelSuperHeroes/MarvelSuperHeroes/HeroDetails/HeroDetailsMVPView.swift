//
//  HeroDetailsMVPView.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

protocol HeroDetailsMVPView: class {
    func update(detailsSections: [(title: String, details: [HeroDetail])])
    func update(section: Int, details: [HeroDetail])
}

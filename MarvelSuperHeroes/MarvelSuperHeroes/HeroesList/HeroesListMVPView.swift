//
//  HeroesListMVPView.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

protocol HeroesListMVPView: class {
    func show(heroes:[Hero])
    func showTopLoading()
    func showBottomLoading()
    func showErrorLoadingHeroes()
}

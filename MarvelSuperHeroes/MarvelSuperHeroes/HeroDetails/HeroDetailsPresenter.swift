//
//  HeroDetailsPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

class HeroDetailsPresenter {
    
    private weak var mvpView: HeroDetailsMVPView!
    private var hero: Hero!
    
    func attach(mvpView: HeroDetailsMVPView, hero: Hero) {
        self.mvpView = mvpView
    }
}

//
//  HeroDetailsPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

class HeroDetailsPresenter {
    
    private var marvelService = MarvelService()
    private weak var mvpView: HeroDetailsMVPView!
    private var hero: Hero!
    
    func attach(mvpView: HeroDetailsMVPView, hero: Hero) {
        self.mvpView = mvpView
        self.hero = hero
    }
    
    func loadHeroDetails() {
        mvpView.update(detailsSections: [
            (title: "Comics", details: []),
            (title: "Events", details: []),
            (title: "Stories", details: []),
            (title: "Series", details: [])
            ])
        marvelService.getComics(forHeroId: hero.id, limit: 3, offset: 0, callback: { [weak self] comics, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    //TODO Show error
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.mvpView.update(section: 0, details: comics ?? [])
            }
        })
    }
}

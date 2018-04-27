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
        // TODO Show loading
        marvelService.getComics(forHeroId: hero.id, limit: 3, offset: 0, callback: { [weak self] comics, error in
            self?.load(heroDetails: comics, error: error, heroDetailsSectionIndex: 0)
        })
        marvelService.getEvents(forHeroId: hero.id, limit: 3, offset: 0, callback: { [weak self] events, error in
            self?.load(heroDetails: events, error: error, heroDetailsSectionIndex: 1)
        })
        marvelService.getStories(forHeroId: hero.id, limit: 3, offset: 0, callback: { [weak self] stories, error in
            self?.load(heroDetails: stories, error: error, heroDetailsSectionIndex: 2)
        })
        marvelService.getSeries(forHeroId: hero.id, limit: 3, offset: 0, callback: { [weak self] series, error in
            self?.load(heroDetails: series, error: error, heroDetailsSectionIndex: 3)
        })
    }
    
    private func load(heroDetails: [HeroDetail]?, error: Error?, heroDetailsSectionIndex: Int) {
        //TODO Increment load request finished counter
        //TODO Hide loading, if its the last request
        
        guard error == nil else {
            DispatchQueue.main.async {
                //TODO Increment error counter
                //TODO Show error, if any exists and its the last request
            }
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.mvpView.update(section: heroDetailsSectionIndex, details: heroDetails ?? [])
        }
    }
}

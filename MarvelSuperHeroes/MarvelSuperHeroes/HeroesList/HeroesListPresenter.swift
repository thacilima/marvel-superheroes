//
//  HeroesListPresenter.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

class HeroesListPresenter {
    
    let marvelService = MarvelService()
    weak var mvpView: HeroesListMVPView!
    
    var heroes: [Hero] = []
    let limit = 20
    var offset = 0
    
    func attach(mvpView: HeroesListMVPView) {
        self.mvpView = mvpView
    }
    
    func loadHeroes() {
        mvpView.showLoadingCollectionData()
        marvelService.getHeroes(limit: limit, offset: offset, callback: { [weak self] heroes, error in
            guard error == nil else {
                //TODO mvpview.showError()
                return
            }
            self?.heroes = heroes ?? []
            
            DispatchQueue.main.async {
                self?.mvpView.show(heroes: heroes ?? [])
            }
        })
    }
}

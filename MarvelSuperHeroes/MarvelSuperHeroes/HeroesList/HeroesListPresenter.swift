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
    
    func refreshHeroes() {
        mvpView.showTopLoading()
        loadHeroes(offset: 0)
    }
    
    func loadHeroesNextPage() {
        if heroes.count > 0 {
            mvpView.showBottomLoading()
            loadHeroes(offset: offset+limit)
        }
    }
    
    private func loadHeroes(offset: Int) {
        marvelService.getHeroes(limit: limit, offset: offset, callback: { [weak self] heroes, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.mvpView.showErrorLoadingHeroes()
                }
                return
            }
            
            self?.offset = offset
            if offset == 0 {
                self?.heroes = []
            }
            self?.heroes.append(contentsOf: heroes ?? [])
            
            DispatchQueue.main.async {
                self?.mvpView.show(heroes: self?.heroes ?? [])
            }
        })
    }
}

//
//  HeroesListViewController.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    let presenter = HeroesListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(mvpView: self)
    }
}

extension HeroesListViewController: HeroesListMVPView {
    
}

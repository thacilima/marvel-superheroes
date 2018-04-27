//
//  HeroDetailsViewController.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    
    private let presenter = HeroDetailsPresenter()
    var hero: Hero! {
        didSet {
            presenter.attach(mvpView: self, hero: hero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension HeroDetailsViewController: HeroDetailsMVPView {
    
}

//
//  HeroesListViewController.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 22/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = HeroesListPresenter()
    var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(mvpView: self)
        presenter.loadHeroes()
    }
}

extension HeroesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "HeroesListItemCellIdentifier"
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }
        
        cell?.textLabel?.text = heroes[indexPath.row].name
        
        return cell
    }
}

extension HeroesListViewController: HeroesListMVPView {
    func show(heroes: [Hero]) {
        self.heroes = heroes
        tableView.reloadData()
    }
}
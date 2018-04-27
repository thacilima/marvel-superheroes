//
//  HeroDetailsViewController.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    
    var details: [(title: String, itens: [HeroDetail])] = []
    
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

extension HeroDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details[section].itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "HeroDetailsItemCellIdentifier"
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        }
        
        let heroDetail = details[indexPath.section].itens[indexPath.row]
        cell.textLabel?.text = heroDetail.name
        cell.detailTextLabel?.text = heroDetail.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return details[section].title
    }
}

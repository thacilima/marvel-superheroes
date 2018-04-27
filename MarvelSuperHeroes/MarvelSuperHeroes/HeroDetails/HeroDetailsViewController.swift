//
//  HeroDetailsViewController.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 26/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

class HeroDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailsSections: [(title: String, details: [HeroDetail])] = []
    
    private let presenter = HeroDetailsPresenter()
    var hero: Hero! {
        didSet {
            presenter.attach(mvpView: self, hero: hero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadHeroDetails()
    }
    
    @IBAction func onClickBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension HeroDetailsViewController: HeroDetailsMVPView {
    func update(detailsSections: [(title: String, details: [HeroDetail])]) {
        self.detailsSections = detailsSections
        tableView.reloadData()
    }
    
    func update(section: Int, details: [HeroDetail]) {
        self.detailsSections[section].details = details
        tableView.reloadSections([section], with: .automatic)
    }
}

extension HeroDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailsSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailsSections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsSections[section].details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "HeroDetailsItemCellIdentifier"
        var cell: UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier:cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        }
        
        let heroDetail = detailsSections[indexPath.section].details[indexPath.row]
        cell.textLabel?.text = heroDetail.name
        cell.detailTextLabel?.text = heroDetail.description
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}

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
    weak var topLoadingRefreshControl: UIRefreshControl!
    weak var bottomActivityIndicator: UIActivityIndicatorView!
    
    let presenter = HeroesListPresenter()
    var heroes: [Hero] = []
    var lastSelectedHero: Hero? = nil
    
    let showHeroDetailsSegue = "ShowHeroDetailsSegue"
    let customPresentAnimatedTransitioning = CustomPresentAnimatedTransitioning()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(mvpView: self)
        setupActivityIndicator()
        setupRefreshControl()
        presenter.refreshHeroes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showHeroDetailsSegue {
            guard let lastSelectedHero = lastSelectedHero else {
                fatalError("You must set a value to lastSelectedHero to perform \(showHeroDetailsSegue)")
            }
            
            segue.destination.transitioningDelegate = self
            
            let vc = segue.destination as! HeroDetailsViewController
            vc.hero = lastSelectedHero
        }
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshData(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        topLoadingRefreshControl = refreshControl
    }
    
    func setupActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.tableFooterView = activityIndicator
        bottomActivityIndicator = activityIndicator
    }
    
    @objc func handleRefreshData(_ refreshControl: UIRefreshControl) {
        presenter.refreshHeroes()
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
        
        let hero = heroes[indexPath.row]
        cell?.textLabel?.text = hero.name
        cell?.imageView?.loadImage(fromUrlString: presenter.imageUrlString(fromMarvelImage: hero.thumbnail), placeholder: #imageLiteral(resourceName: "placeholder"))
        return cell
    }
}

extension HeroesListViewController: UITableViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            presenter.loadHeroesNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedHero = heroes[indexPath.row]
        performSegue(withIdentifier: showHeroDetailsSegue, sender: self)
    }
}

extension HeroesListViewController: HeroesListMVPView {
    func showErrorLoadingHeroes() {
        bottomActivityIndicator.stopAnimating()
        if topLoadingRefreshControl.isRefreshing {
            topLoadingRefreshControl.endRefreshing()
            
            let label = UILabel(frame: CGRect.zero)
            label.numberOfLines = 0
            label.text = "Oops! Sorry, our heroes might be acting.\nPull to try calling them again!"
            label.font = UIFont.boldSystemFont(ofSize: 12.0)
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.backgroundColor = UIColor.red.withAlphaComponent(0.6)
            tableView.tableHeaderView = label
            label.sizeToFit()
            tableView.reloadData()
        }
    }
    
    func show(heroes: [Hero]) {
        self.heroes = heroes
        tableView.reloadData()
        topLoadingRefreshControl.endRefreshing()
        bottomActivityIndicator.stopAnimating()
        tableView.tableHeaderView = nil
    }
    
    func showTopLoading() {
        topLoadingRefreshControl.beginRefreshing()
    }
    
    func showBottomLoading() {
        bottomActivityIndicator.startAnimating()
    }
}

extension HeroesListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimatedTransitioning
    }
}

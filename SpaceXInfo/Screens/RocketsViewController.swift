//
//  RocketsViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class RocketsViewController: UIViewController {
    
    let tableView = UITableView()
    var dataSource = RocketsDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getRockets()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Rockets"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.removeExcessCells()
        
        dataSource.selectedItemAtIndex { [weak self] indexPath in
            guard let self = self else { return }
            
            let rocket = self.dataSource.rockets[indexPath.row]
            let destVC = RocketInfoViewController(rocket: rocket)
            let navController = UINavigationController(rootViewController: destVC)
            
            self.present(navController, animated: true)
        }
        
        tableView.register(RocketCell.self, forCellReuseIdentifier: RocketCell.reuseID)
    }
    
    func getRockets() {
        NetworkManager.shared.getRockets { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let rockets):
                self.updateUI(with: rockets)
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateUI(with rockets: [Rocket]) {
        self.dataSource.rockets = rockets
        tableView.reloadDataOnMainThread()
    }
}

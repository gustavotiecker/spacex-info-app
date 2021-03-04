//
//  UpcomingLaunchesViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class UpcomingLaunchesViewController: UIViewController {
    
    let tableView = UITableView()
    var dataSource = LaunchesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        confiugreTableView()
        getLaunches()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Upcoming Launches"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func confiugreTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.removeExcessCells()
        
        dataSource.selectedItemAtIndex { [weak self] indexPath in
            guard let self = self else { return }
            
            let launch = self.dataSource.upcomingLaunches[indexPath.row]
            let destVC = LaunchInfoViewController(launch: launch)
            let navController = UINavigationController(rootViewController: destVC)

            self.present(navController, animated: true)
        }
        
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseID)
    }
    
    func getLaunches() {
        NetworkManager.shared.getUpcomingLaunches { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let launches):
                self.updateUI(with: launches)
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateUI(with launches: [Launch]) {
        self.dataSource.upcomingLaunches = launches
        tableView.reloadDataOnMainThread()
    }
}

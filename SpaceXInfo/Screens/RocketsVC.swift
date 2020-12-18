//
//  RocketsVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class RocketsVC: UIViewController {
    
    let tableView = UITableView()
    var rockets: [Rocket] = []

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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(RocketCell.self, forCellReuseIdentifier: RocketCell.reuseID)
    }
    
    func getRockets() {
        NetworkManager.shared.getRockets { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let rockets):
                self.updateUI(with: rockets)
            case .failure(let error):
                self.presentAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateUI(with rockets: [Rocket]) {
        self.rockets = rockets
        tableView.reloadDataOnMainThread()
    }
}

extension RocketsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketCell.reuseID) as! RocketCell
        let rocket = rockets[indexPath.row]
        
        cell.set(rocket: rocket)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rocket = rockets[indexPath.row]
        
        let destVC = RocketInfoVC(rocket: rocket)
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

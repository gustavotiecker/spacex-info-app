//
//  UpcomingLaunchesVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class UpcomingLaunchesVC: UIViewController {
    
    let tableView = UITableView()
    var upcomingLaunches: [Launch] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        confiugreTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)

        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseID)
    }
    
    func getLaunches() {
        NetworkManager.shared.getUpcomingLaunches { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let launches):
                self.updateUI(with: launches)
            case .failure(let error):
                self.presentAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateUI(with launches: [Launch]) {
        self.upcomingLaunches = launches
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension UpcomingLaunchesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseID) as! LaunchCell
        let launch = upcomingLaunches[indexPath.row]
        
        cell.set(launch: launch)
        return cell
    }
    
    
}

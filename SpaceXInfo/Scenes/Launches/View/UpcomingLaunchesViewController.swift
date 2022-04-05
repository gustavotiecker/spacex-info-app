//
//  UpcomingLaunchesViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class UpcomingLaunchesViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: UpcomingLaunchesBusinessLogic
    
    // MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.removeExcessCells()
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseID)
        return tableView
    }()
    
    // MARK: - Initializers
    init(viewModel: UpcomingLaunchesBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupViewCode()
        setupDelegates()
        viewModel.fetchUpcomingLaunches()
    }
    
    // MARK: - Private methods
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        title = "Upcoming Launches"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension UpcomingLaunchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = UINavigationController(
            rootViewController: LaunchInfoViewController(
                launch: viewModel.getLaunch(at: indexPath)
            )
        )
        
        self.present(navController, animated: true)
    }
}

extension UpcomingLaunchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseID) as! LaunchCell
        cell.set(launch: viewModel.getLaunch(at: indexPath))
        return cell
    }
}

extension UpcomingLaunchesViewController: UpcomingLaunchesViewDelegate {
    
    func didFetchUpcomingLaunchesWithSuccess() {
        tableView.reloadDataOnMainThread()
    }
    
    func didFetchUpcomingLaunchesWithError(message: String) {
        presentAlert(title: "Error", message: message, buttonTitle: "Ok")
    }
}

extension UpcomingLaunchesViewController: ViewCode {
    
    func setupComponents() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.frame = view.bounds
    }
}

//
//  RocketsViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class RocketsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: RocketsBusinessLogic
    
    // MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.removeExcessCells()
        tableView.register(RocketCell.self, forCellReuseIdentifier: RocketCell.reuseID)
        return tableView
    }()

    // MARK: - Initializers
    init(viewModel: RocketsBusinessLogic) {
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
        viewModel.fetchRockets()
    }
    
    // MARK: - Public methods
    func setupViewController() {
        view.backgroundColor = .systemBackground
        title = "Rockets"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RocketsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = UINavigationController(
            rootViewController: RocketInfoViewController(
                rocket: viewModel.getRocket(at: indexPath)
            )
        )
        
        self.present(navController, animated: true)
    }
}

extension RocketsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketCell.reuseID) as! RocketCell
        cell.set(rocket: viewModel.getRocket(at: indexPath))
        return cell
    }
}

extension RocketsViewController: RocketsViewDelegate {
    func didFetchRocketsWithSuccess() {
        tableView.reloadDataOnMainThread()
    }
    
    func didFetchRocketsWithError(message: String) {
        presentAlert(title: "Error", message: message, buttonTitle: "Ok")
    }
}

extension RocketsViewController: ViewCode {
    func setupComponents() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.frame = view.bounds
    }
}

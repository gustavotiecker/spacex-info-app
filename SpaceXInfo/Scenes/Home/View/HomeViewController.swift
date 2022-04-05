//
//  HomeViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 05/01/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeBusinessLogic
        
    private lazy var latestLaunchView: SPXLatestLaunchView = {
        let view = SPXLatestLaunchView(delegate: self)
        return view
    }()
    
    private lazy var nextLaunchView: SPXNextLaunchView = {
        let view = SPXNextLaunchView()
        return view
    }()
    
    // MARK: - Initializers
    init(viewModel: HomeBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        viewModel.fetchLatestLaunch()
        viewModel.fetchNextLaunch()
        setupViewCode()
    }
    
    func setupViewController() {
        view.backgroundColor = .systemBackground
        latestLaunchView.isHidden = true
        nextLaunchView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func updateLatestLaunchUI(with launch: Launch) {
        DispatchQueue.main.async {
            self.latestLaunchView.updateUI(with: launch)
            self.latestLaunchView.isHidden = false
        }
    }
    
    private func updateNextLaunchUI(with launch: Launch) {
        DispatchQueue.main.async {
            self.nextLaunchView.updateUI(withDateString: launch.date.convertToMonthDayYearTimeFormat())
            self.nextLaunchView.isHidden = false
        }
    }
}

extension HomeViewController: SPXLatestLaunchDelegate {
    
    func didTapRedditButton() {
        if let campaignURL = viewModel.getLatestLaunch()?.campaignURL {
            presentSafariVC(with: campaignURL)
        } else {
            presentAlert(title: "Error", message: "Campaign page not found.", buttonTitle: "Ok")
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    
    func didFetchLatestLaunchWithSuccess() {
        guard let latestLaunch = viewModel.getLatestLaunch() else { return }
        updateLatestLaunchUI(with: latestLaunch)
    }
    
    func didFetchNextLaunchWithSuccess() {
        guard let nextLaunch = viewModel.getNextLaunch() else { return }
        updateNextLaunchUI(with: nextLaunch)
    }
    
    func didFetchWithError(message: String) {
        presentAlert(title: "Error", message: message, buttonTitle: "Ok")
    }
}

extension HomeViewController: ViewCode {
    
    func setupComponents() {
        view.addSubviews(latestLaunchView, nextLaunchView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            latestLaunchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            latestLaunchView.heightAnchor.constraint(equalToConstant: 360),
            latestLaunchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            latestLaunchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            nextLaunchView.topAnchor.constraint(equalTo: latestLaunchView.bottomAnchor, constant: 50),
            nextLaunchView.heightAnchor.constraint(equalToConstant: 150),
            nextLaunchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            nextLaunchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
}

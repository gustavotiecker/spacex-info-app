//
//  HomeVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 05/01/21.
//

import UIKit

class HomeVC: UIViewController {
        
    var latestLaunchView = SPXLatestLaunchView()
    var nextLaunchView = SPXNextLaunchView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getLatestLaunch()
        getNextLaunch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getLatestLaunch() {
        NetworkManager.shared.getLatestLaunch { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let launch):
                DispatchQueue.main.async {
                    self.updateLatestLaunchUI(with: launch)
                }
            case .failure(let error):
                self.presentAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func getNextLaunch() {
        NetworkManager.shared.getNextLaunch { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let launch):
                DispatchQueue.main.async {
                    self.updateNextLaunchUI(with: launch)
                }
            case .failure(let error):
                self.presentAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func updateLatestLaunchUI(with launch: Launch) {
        latestLaunchView = SPXLatestLaunchView(launch: launch)
        configure()
    }
    
    private func updateNextLaunchUI(with launch: Launch) {
        nextLaunchView = SPXNextLaunchView(withStringDate: launch.date.convertToMonthDayYearTimeFormat())
        configure()
    }
    
    private func configure() {
        let cardViews = [latestLaunchView, nextLaunchView]
        
        for cardView in cardViews {
            cardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(cardView)
            
            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
                cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            ])
        }
        
        NSLayoutConstraint.activate([
            latestLaunchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            latestLaunchView.heightAnchor.constraint(equalToConstant: 360),
            
            nextLaunchView.topAnchor.constraint(equalTo: latestLaunchView.bottomAnchor, constant: 50),
            nextLaunchView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}

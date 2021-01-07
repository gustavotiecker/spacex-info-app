//
//  HomeVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 05/01/21.
//

import UIKit

class HomeVC: UIViewController {
    
    let logoImageView = UIImageView()
    let nextLaunchView = SPXNextLaunchView(launchName: "Discover", withStringDate: "01 21, 2021 - 13:30:00")
    let latestLaunchButton = SPXButton(backgroundColor: .systemIndigo, title: "Latest Launch")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, nextLaunchView, latestLaunchButton)
        configureLogoImageView()
        configureNextLaunchView()
        configureLatestLaunchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.spaceXInfoLogo
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureNextLaunchView() {
        nextLaunchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextLaunchView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 28),
            nextLaunchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            nextLaunchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            nextLaunchView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureLatestLaunchButton() {
        NSLayoutConstraint.activate([
            latestLaunchButton.topAnchor.constraint(equalTo: nextLaunchView.bottomAnchor, constant: 28),
            latestLaunchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            latestLaunchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            latestLaunchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

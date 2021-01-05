//
//  HomeVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 05/01/21.
//

import UIKit

class HomeVC: UIViewController {
    
    let logoImageView = UIImageView()
    let latestLaunchButton = SPXButton(backgroundColor: .systemIndigo, title: "Latest Launch")
    let nextLaunchButton = SPXButton(backgroundColor: .systemIndigo, title: "Next Launch")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, latestLaunchButton)
        configureLogoImageView()
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
    
    private func configureLatestLaunchButton() {
        NSLayoutConstraint.activate([
            latestLaunchButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            latestLaunchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            latestLaunchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            latestLaunchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

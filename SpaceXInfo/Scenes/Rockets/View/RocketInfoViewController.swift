//
//  RocketInfoViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 17/12/20.
//

import UIKit

class RocketInfoViewController: UIViewController {
    
    private var rocket: Rocket
    
    private let headerView = SPXRocketInfoHeaderView()
    private let rocketSpecsView = SPXRocketSpecsView()
    
    
    init(rocket: Rocket) {
        self.rocket = rocket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupViewCode()
    }
    
    func setupViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension RocketInfoViewController: ViewCode {
    
    func setupComponents() {
        headerView.setup(with: rocket)
        rocketSpecsView.setup(with: rocket, delegate: self)
        
        view.addSubviews(headerView, rocketSpecsView)
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        rocketSpecsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320),
            
            rocketSpecsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            rocketSpecsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            rocketSpecsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            rocketSpecsView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
}

extension RocketInfoViewController: SPXItemDelegate {
    
    func didTapWikipediaButton(for rocket: Rocket) {
        presentSafariVC(with: rocket.wikipediaURL)
    }
}

//
//  RocketInfoVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 17/12/20.
//

import UIKit

class RocketInfoVC: UIViewController {
    
    var rocket: Rocket!
    
    init(rocket: Rocket) {
        super.init(nibName: nil, bundle: nil)
        self.rocket = rocket;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        //configureUIElements()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
//    func configureUIElements() {
//        self.add(childVC: SPXRocketInfoHeaderVC(rocket: rocket), to: self.headerView)
//    }
    
    func layoutUI() {
        let headerView = SPXRocketInfoHeaderView(rocket: rocket)
        let rocketSpecsView = SPXRocketSpecsView(rocket: rocket, delegate: self)
        view.addSubviews(headerView, rocketSpecsView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        rocketSpecsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            rocketSpecsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            rocketSpecsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            rocketSpecsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            rocketSpecsView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension RocketInfoVC: SPXItemDelegate {
    
    func didTapWikipediaButton(for rocket: Rocket) {
        presentSafariVC(with: rocket.wikipediaURL)
    }
}

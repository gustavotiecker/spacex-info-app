//
//  LaunchInfoViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 12/01/21.
//

import UIKit

class LaunchInfoViewController: UIViewController {
    
    // MARK: - Properties
    private var launch: Launch
    
    private let upcomingLaunchInfoView = SPXUpcomingLaunchInfoView()
    
    // MARK: - Initializers
    init(launch: Launch) {
        self.launch = launch
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
    }
    
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension LaunchInfoViewController: ViewCode {
    
    func setupComponents() {
        upcomingLaunchInfoView.setup(with: launch, delegate: self)
        view.addSubview(upcomingLaunchInfoView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            upcomingLaunchInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            upcomingLaunchInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upcomingLaunchInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upcomingLaunchInfoView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
}

extension LaunchInfoViewController: SPXUpcomingLaunchDelegate {
    
    func didTapRedditButton(for launch: Launch) {
        if let campaignURL = launch.campaignURL {
            presentSafariVC(with: campaignURL)
        } else {
            presentAlert(title: "Error", message: "Campaign page not found.", buttonTitle: "Ok")
        }
    }
}

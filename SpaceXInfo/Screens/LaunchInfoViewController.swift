//
//  LaunchInfoViewController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 12/01/21.
//

import UIKit

class LaunchInfoViewController: UIViewController {
    
    var launch: Launch!
    
    init(launch: Launch) {
        super.init(nibName: nil, bundle: nil)
        self.launch = launch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutUI() {
        let upcomingLaunchInfoView = SPXUpcomingLaunchInfoView(launch: launch)
        view.addSubview(upcomingLaunchInfoView)
        upcomingLaunchInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            upcomingLaunchInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            upcomingLaunchInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upcomingLaunchInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upcomingLaunchInfoView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

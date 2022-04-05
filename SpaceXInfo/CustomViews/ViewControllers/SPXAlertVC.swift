//
//  SPXAlertVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import UIKit

class SPXAlertVC: UIViewController {
    
    // MARK: - Properties
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    // MARK: - UI Elements
    private let containerView = SPXAlertContainerView()
    private let titleLabel = SPXTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = SPXBodyLabel(textAlignment: .center)
    private let actionButton = SPXButton(backgroundColor: .systemRed, title: "Ok")
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        setupViewCode()
    }
    
    // MARK: - Actions
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

extension SPXAlertVC: ViewCode {
    func setupComponents() {
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    func setupExtraConfiguration() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
    }
}

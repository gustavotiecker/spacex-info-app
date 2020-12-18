//
//  SPXRocketInfoHeaderVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 17/12/20.
//

import UIKit

class SPXRocketInfoHeaderVC: UIViewController {
    
    let avatarImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .left, fontSize: 34)
    let activeLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let successRateLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let descriptionLabel = SPXBodyLabel(textAlignment: .left)
    
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
        view.addSubviews(avatarImageView, nameLabel, activeLabel, successRateLabel, descriptionLabel)
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        avatarImageView.downloadImage(fromURL: rocket.flickrImages[0])
        nameLabel.text = rocket.name
        styleActiveLabel()
        successRateLabel.text = "\(rocket.successRatePct) %"
        descriptionLabel.text = rocket.description
        descriptionLabel.numberOfLines = 3
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            activeLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            activeLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            activeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            successRateLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            successRateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            successRateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            successRateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func styleActiveLabel() {
        if (rocket.active) {
            activeLabel.text = "Active"
            activeLabel.textColor = .systemGreen
        } else {
            activeLabel.text = "Inactive"
            activeLabel.textColor = .systemRed
        }
    }
}

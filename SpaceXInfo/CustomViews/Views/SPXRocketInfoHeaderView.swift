//
//  SPXRocketInfoHeaderView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 18/12/20.
//

import UIKit

class SPXRocketInfoHeaderView: UIView {
    
    let avatarImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .left, fontSize: 34)
    let activeLabel = SPXSecondaryTitleLabel(fontSize: 20)
    let successRateLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let descriptionLabel = SPXBodyLabel(textAlignment: .left)
    
    let padding: CGFloat = 8
    let imagePadding: CGFloat = 12
    
    var rocket: Rocket!
    
    init(rocket: Rocket) {
        super.init(frame: .zero)
        self.rocket = rocket
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(avatarImageView, nameLabel, activeLabel, successRateLabel, descriptionLabel)
        configureAvatarImageView()
        configureNameLabel()
        configureActiveLabel()
        configureSuccessRateLabel()
        configureDescriptionLabel()
    }
    
    private func configureAvatarImageView() {
        avatarImageView.downloadImage(fromURL: rocket.images[0])
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: imagePadding),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: imagePadding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureNameLabel() {
        nameLabel.text = rocket.name
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: imagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func configureActiveLabel() {
        if (rocket.isActive) {
            activeLabel.text = "Active"
            activeLabel.textColor = .systemGreen
        } else {
            activeLabel.text = "Inactive"
            activeLabel.textColor = .systemRed
        }
        
        NSLayoutConstraint.activate([
            activeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            activeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            activeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            activeLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureSuccessRateLabel() {
        successRateLabel.text = "Success rate: \(rocket.successRatePct)%"
        
        NSLayoutConstraint.activate([
            successRateLabel.topAnchor.constraint(equalTo: activeLabel.bottomAnchor, constant: padding),
            successRateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            successRateLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            successRateLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.text = rocket.description
        descriptionLabel.numberOfLines = 7
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: imagePadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

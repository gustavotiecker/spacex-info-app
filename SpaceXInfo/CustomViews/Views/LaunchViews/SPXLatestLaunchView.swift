//
//  SPXLatestLaunchView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/01/21.
//

import UIKit

protocol SPXLatestLaunchDelegate: class {
    func didTapRedditButton()
}

class SPXLatestLaunchView: UIView {
    
    weak var delegate: SPXLatestLaunchDelegate!
    
    let titleLabel = SPXTitleLabel(textAlignment: .left, fontSize: 22)
    let patchImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .center, fontSize: 16)
    let successLabel = SPXSecondaryTitleLabel(fontSize: 12)
    let dateLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let redditButton = SPXButton(backgroundColor: .systemIndigo, title: "Campaign page")
    
    let lateralPadding: CGFloat = 30
    let topPadding: CGFloat = 20
    
    init(delegate: SPXLatestLaunchDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        
        turnIntoCard(view: self)
        configureElementsPosition()
        configureRedditButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with launch: Launch) {
        titleLabel.text = "Latest launch"
        titleLabel.textColor = .systemIndigo
        nameLabel.text = launch.missionName
        dateLabel.text = launch.date.convertToMonthDayYearTimeFormat()
        
        if let successLaunch = launch.success {
            if (successLaunch) {
                successLabel.text = "The mission was successfully completed"
                successLabel.textColor = .systemGreen
            } else {
                successLabel.text = "Mission failed"
                successLabel.textColor = .systemRed
            }
        }
        
        if let smallPatchURL = launch.smallPatchURL {
            patchImageView.downloadImage(fromURL: smallPatchURL)
        }
    }
    
    private func configureElementsPosition() {
        addSubviews(titleLabel, patchImageView, nameLabel, successLabel, dateLabel, redditButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateralPadding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateralPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            patchImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding),
            patchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            patchImageView.widthAnchor.constraint(equalToConstant: 100),
            patchImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: patchImageView.bottomAnchor, constant: topPadding / 2),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            successLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: topPadding),
            successLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            successLabel.heightAnchor.constraint(equalToConstant: 14),
            
            dateLabel.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: topPadding / 2),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            redditButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: topPadding),
            redditButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateralPadding),
            redditButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateralPadding),
            redditButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureRedditButton() {
        redditButton.addTarget(self, action: #selector(redditButtonTapped), for: .touchUpInside)
    }
    
    @objc func redditButtonTapped() {
        delegate.didTapRedditButton()
    }
}

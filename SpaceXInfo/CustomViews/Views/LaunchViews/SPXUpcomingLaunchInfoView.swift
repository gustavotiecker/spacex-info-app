//
//  SPXUpcomingLaunchInfoView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 12/01/21.
//

import UIKit

protocol SPXUpcomingLaunchDelegate: AnyObject {
    func didTapRedditButton(for launch: Launch)
}

class SPXUpcomingLaunchInfoView: UIView {
    
    weak var delegate: SPXUpcomingLaunchDelegate!
    
    let patchImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .center, fontSize: 32)
    let detailsLabel = SPXBodyLabel(textAlignment: .left)
    let dateLabel = SPXSecondaryTitleLabel(fontSize: 20)
    let redditButton = SPXButton(backgroundColor: .systemIndigo, title: "Campaign page")
    
    let padding: CGFloat = 12
    let imagePadding: CGFloat = 36
    let imageTextPadding: CGFloat = 18
    
    var launch: Launch!
    
    init(launch: Launch, delegate: SPXUpcomingLaunchDelegate) {
        super.init(frame: .zero)
        self.launch = launch
        self.delegate = delegate
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(patchImageView, nameLabel, detailsLabel, dateLabel, redditButton)
        configurePatchImageView()
        configureNameLabel()
        configureDetailsLabel()
        configureDateLabel()
        configureRedditButton()
    }
    
    private func configurePatchImageView() {
        if let largePatchURL = launch.largePatchURL {
            patchImageView.downloadImage(fromURL: largePatchURL)
        }
        
        NSLayoutConstraint.activate([
            patchImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: imagePadding),
            patchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            patchImageView.widthAnchor.constraint(equalToConstant: 120),
            patchImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func configureNameLabel() {
        nameLabel.text = launch.missionName
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: patchImageView.bottomAnchor, constant: imageTextPadding),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func configureDateLabel() {
        dateLabel.text = launch.date.convertToMonthDayYearTimeFormat()
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding * 2),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureRedditButton() {
        redditButton.addTarget(self, action: #selector(redditButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            redditButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding * 2),
            redditButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            redditButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            redditButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureDetailsLabel() {
        detailsLabel.text = launch.missionDetails
        detailsLabel.numberOfLines = 9
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: redditButton.bottomAnchor, constant: padding),
            detailsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            detailsLabel.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    @objc func redditButtonTapped() {
        delegate.didTapRedditButton(for: launch)
    }
}

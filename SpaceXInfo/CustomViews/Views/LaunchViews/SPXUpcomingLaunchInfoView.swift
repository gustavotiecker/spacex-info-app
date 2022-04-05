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
    
    // MARK: - Properties
    weak var delegate: SPXUpcomingLaunchDelegate?
    private var launch: Launch?
    
    // MARK: - UI Elements
    let patchImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .center, fontSize: 32)
    let detailsLabel = SPXBodyLabel(textAlignment: .left)
    let dateLabel = SPXSecondaryTitleLabel(fontSize: 20)
    let redditButton = SPXButton(backgroundColor: .systemIndigo, title: "Campaign page")
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(with launch: Launch, delegate: SPXUpcomingLaunchDelegate) {
        self.launch = launch
        self.delegate = delegate
        setupViewCode()
    }
    
    // MARK: - Actions
    @objc private func redditButtonTapped() {
        guard let launch = launch else { return }
        delegate?.didTapRedditButton(for: launch)
    }
}

extension SPXUpcomingLaunchInfoView: ViewCode {
    
    func setupComponents() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(patchImageView, nameLabel, detailsLabel, dateLabel, redditButton)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 12
        let imagePadding: CGFloat = 36
        let imageTextPadding: CGFloat = 18
        
        NSLayoutConstraint.activate([
            patchImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: imagePadding),
            patchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            patchImageView.widthAnchor.constraint(equalToConstant: 120),
            patchImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: patchImageView.bottomAnchor, constant: imageTextPadding),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 34),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding * 2),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 22),
            
            redditButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding * 2),
            redditButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            redditButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            redditButton.heightAnchor.constraint(equalToConstant: 50),
            
            detailsLabel.topAnchor.constraint(equalTo: redditButton.bottomAnchor, constant: padding),
            detailsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            detailsLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func setupExtraConfiguration() {
        guard let launch = launch else { return }
        
        if let largePatchURL = launch.largePatchURL {
            patchImageView.downloadImage(fromURL: largePatchURL)
        }
        
        nameLabel.text = launch.missionName
        dateLabel.text = launch.date.convertToMonthDayYearTimeFormat()
        detailsLabel.text = launch.missionDetails
        detailsLabel.numberOfLines = 9
        
        redditButton.addTarget(self, action: #selector(redditButtonTapped), for: .touchUpInside)
    }
}

//
//  SPXLatestLaunchView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/01/21.
//

import UIKit

class SPXLatestLaunchView: UIView {
    
    //var launch: Launch!
    
    let titleLabel = SPXTitleLabel(textAlignment: .left, fontSize: 22)
    let patchImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .center, fontSize: 16)
    let successLabel = SPXSecondaryTitleLabel(fontSize: 12)
    let dateLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let callToActionButton = SPXButton(backgroundColor: .systemIndigo, title: "Discussion page")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        turnIntoCard(view: self)
        configureElementsPosition()
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
        addSubviews(titleLabel, patchImageView, nameLabel, successLabel, dateLabel, callToActionButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            patchImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            patchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            patchImageView.widthAnchor.constraint(equalToConstant: 100),
            patchImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: patchImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            successLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            successLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            successLabel.heightAnchor.constraint(equalToConstant: 14),
            
            dateLabel.topAnchor.constraint(equalTo: successLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            callToActionButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            callToActionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            callToActionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

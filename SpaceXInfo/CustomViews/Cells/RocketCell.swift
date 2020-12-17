//
//  RocketCell.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 16/12/20.
//

import UIKit

class RocketCell: UITableViewCell {
    
    static let reuseID = "RocketCell"
    let avatarImageView = SXAvatarImageView(frame: .zero)
    let rocketNameLabel = SXTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(rocket: Rocket) {
        avatarImageView.downloadImage(fromURL: rocket.flickrImages[0])
        rocketNameLabel.text = rocket.name
    }
    
    func configure() {
        addSubview(avatarImageView)
        addSubview(rocketNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            rocketNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rocketNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
            rocketNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            rocketNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

//
//  RocketCell.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 16/12/20.
//

import UIKit

class RocketCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID = "RocketCell"
    
    // MARK: - UI Elements
    let avatarImageView = SPXAvatarImageView(frame: .zero)
    let rocketNameLabel = SPXTitleLabel(textAlignment: .left, fontSize: 26)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func set(rocket: Rocket) {
        avatarImageView.downloadImage(fromURL: rocket.images[0])
        rocketNameLabel.text = rocket.name
    }
}

extension RocketCell: ViewCode {
    
    func setupComponents() {
        addSubviews(avatarImageView, rocketNameLabel)
    }
    
    func setupConstraints() {
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
    
    func setupExtraConfiguration() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}

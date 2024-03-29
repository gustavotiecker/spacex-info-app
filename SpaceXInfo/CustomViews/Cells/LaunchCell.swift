//
//  LaunchCell.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 08/12/20.
//

import UIKit

class LaunchCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID = "LaunchCell"
    
    // MARK: - UI Elements
    let avatarImageView = SPXAvatarImageView(frame: .zero)
    let missionName = SPXTitleLabel(textAlignment: .left, fontSize: 16)
    let missionDate = SPXBodyLabel(textAlignment: .left)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func set(launch: Launch) {
        missionName.text = launch.missionName
        if let smallPatchURL = launch.smallPatchURL {
            avatarImageView.downloadImage(fromURL: smallPatchURL)
        }
        missionDate.text = launch.date.convertToMonthDayYearTimeFormat()
    }
}

extension LaunchCell: ViewCode {
    
    func setupComponents() {
        addSubviews(avatarImageView, missionName, missionDate)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 8
        let paddingTopBottom: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            missionName.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingTopBottom),
            missionName.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            missionName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            missionName.heightAnchor.constraint(equalToConstant: 20),
            
            missionDate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -paddingTopBottom),
            missionDate.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            missionDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            missionDate.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupExtraConfiguration() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}

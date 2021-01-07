//
//  SPXNextLaunchView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 06/01/21.
//

import UIKit

class SPXNextLaunchView: UIView {
    
    let titleLabel = SPXTitleLabel(textAlignment: .center, fontSize: 16)
    let launchNameLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let launchDateLabel = SPXTitleLabel(textAlignment: .center, fontSize: 22)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(launchName: String, withStringDate launchDate: String) {
        self.init(frame: .zero)
        titleLabel.text = "Next Launch"
        titleLabel.backgroundColor = .systemIndigo
        titleLabel.textColor = .white
        launchNameLabel.text = "Name: \(launchName)"
        launchDateLabel.text = launchDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(titleLabel, launchNameLabel, launchDateLabel)
        
        layer.cornerRadius = 18
        backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            launchNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            launchNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            launchNameLabel.heightAnchor.constraint(equalToConstant: 14),
            
            launchDateLabel.topAnchor.constraint(equalTo: launchNameLabel.bottomAnchor, constant: 20),
            launchDateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            launchDateLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

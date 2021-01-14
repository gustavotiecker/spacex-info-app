//
//  SPXNextLaunchView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 06/01/21.
//

import UIKit

class SPXNextLaunchView: UIView {
    
    let titleLabel = SPXTitleLabel(textAlignment: .left, fontSize: 22)
    let dateLabel = SPXTitleLabel(textAlignment: .center, fontSize: 22)
    
    let padding: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureNextLaunchCard()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withDateString launchDate: String) {
        dateLabel.text = launchDate
    }
    
    private func configureNextLaunchCard() {
        turnIntoCard(view: self)
        
        titleLabel.text = "Next Launch in"
        titleLabel.textColor = .systemIndigo
    }
    
    private func configure() {
        addSubviews(titleLabel, dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(withStringDate launchDate: String) {
        super.init(frame: .zero)
        
        dateLabel.text = launchDate
        configure()
        configureNextLaunchCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNextLaunchCard() {
        titleLabel.text = "Next Launch in"
        titleLabel.textColor = .systemIndigo
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.7
    }
    
    private func configure() {
        addSubviews(titleLabel, dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

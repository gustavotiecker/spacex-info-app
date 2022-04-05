//
//  SPXNextLaunchView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 06/01/21.
//

import UIKit

class SPXNextLaunchView: UIView {
    
    // MARK: - UI Elements
    let titleLabel = SPXTitleLabel(textAlignment: .left, fontSize: 22)
    let dateLabel = SPXTitleLabel(textAlignment: .center, fontSize: 22)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        turnIntoCard(view: self)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func updateUI(withDateString launchDate: String) {
        dateLabel.text = launchDate
    }
}

extension SPXNextLaunchView: ViewCode {
    
    func setupComponents() {
        addSubviews(titleLabel, dateLabel)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 30
        
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setupExtraConfiguration() {
        titleLabel.text = "Next Launch in"
        titleLabel.textColor = .systemIndigo
    }
}

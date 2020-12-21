//
//  SPXRocketSpecsView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 18/12/20.
//

import UIKit

class SPXRocketSpecsView: UIView {
    
    let companyLabel = SPXSecondaryTitleLabel(fontSize: 20)
    let countryLabel = SPXBodyLabel(textAlignment: .left)
    let heightLabel = SPXBodyLabel(textAlignment: .left)
    let diameterLabel = SPXBodyLabel(textAlignment: .left)
    let massLabel = SPXBodyLabel(textAlignment: .left)
    let wikipediaButton = SPXButton(backgroundColor: .systemPink, title: "Wikipedia's page")
    
    let padding: CGFloat = 8
    
    var rocket: Rocket!
    
    init(rocket: Rocket) {
        super.init(frame: .zero)
        self.rocket = rocket
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(companyLabel)
        configureCompanyLabel()
    }
    
    private func configureCompanyLabel() {
        companyLabel.text = "Company: \(rocket.company)"
        
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            companyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            companyLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func configureCountryLabel() {
        countryLabel.text = "Contry: \(rocket.country)"
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: padding),
            countryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            countryLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

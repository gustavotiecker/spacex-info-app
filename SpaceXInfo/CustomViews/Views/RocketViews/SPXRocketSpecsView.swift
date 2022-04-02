//
//  SPXRocketSpecsView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 18/12/20.
//

import UIKit

protocol SPXItemDelegate: AnyObject {
    func didTapWikipediaButton(for rocket: Rocket)
}

class SPXRocketSpecsView: UIView {
    
    weak var delegate: SPXItemDelegate!
    
    let companyLabel = SPXSecondaryTitleLabel(fontSize: 20)
    let countryLabel = SPXBodyLabel(textAlignment: .left)
    
    let diameterItem = SPXRocketSpecItem()
    let heightItem = SPXRocketSpecItem()
    let massItem = SPXRocketSpecItem()
    var itemViews: [UIView] = []
    
    let wikipediaButton = SPXButton(backgroundColor: .systemIndigo, title: "Wikipedia's page")
    
    let padding: CGFloat = 12
    
    var rocket: Rocket!
    
    init(rocket: Rocket, delegate: SPXItemDelegate) {
        super.init(frame: .zero)
        self.rocket = rocket
        self.delegate = delegate
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 18
        backgroundColor = .secondarySystemBackground
        
        addSubviews(companyLabel, countryLabel, diameterItem, heightItem, massItem, wikipediaButton)
        configureCompanyLabel()
        configureCountryLabel()
        configureSpecItems()
        configureWikipediaButton()
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
        countryLabel.text = "Country: \(rocket.country)"
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: padding),
            countryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countryLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureSpecItems() {
        heightItem.set(itemInfoType: .height, withValue: rocket.height)
        diameterItem.set(itemInfoType: .diameter, withValue: rocket.diameter)
        massItem.set(itemInfoType: .mass, withValue: Float(rocket.mass))
        
        itemViews = [diameterItem, heightItem, massItem]
        
        for itemView in itemViews {
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: padding * 2),
                itemView.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
        
        NSLayoutConstraint.activate([
            diameterItem.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            
            heightItem.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            massItem.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureWikipediaButton() {
        wikipediaButton.addTarget(self, action: #selector(wikipediaButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            wikipediaButton.topAnchor.constraint(equalTo: diameterItem.bottomAnchor, constant: 48),
            wikipediaButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            wikipediaButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            wikipediaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func wikipediaButtonTapped() {
        delegate.didTapWikipediaButton(for: rocket)
    }
}

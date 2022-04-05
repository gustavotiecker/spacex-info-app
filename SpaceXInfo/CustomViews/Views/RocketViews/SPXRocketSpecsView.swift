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
    
    // MARK: - Properties
    weak var delegate: SPXItemDelegate?
    private var rocket: Rocket?
    
    // MARK: - UI Elements
    let companyLabel = SPXSecondaryTitleLabel(fontSize: 20)
    let countryLabel = SPXBodyLabel(textAlignment: .left)
    let diameterItem = SPXRocketSpecItem()
    let heightItem = SPXRocketSpecItem()
    let massItem = SPXRocketSpecItem()
    var itemViews: [UIView] = []
    let wikipediaButton = SPXButton(backgroundColor: .systemIndigo, title: "Wikipedia's page")
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(with rocket: Rocket, delegate: SPXItemDelegate) {
        self.rocket = rocket
        self.delegate = delegate
        setupViewCode()
    }
    
    // MARK: - Private methods
    private func setupView() {
        layer.cornerRadius = 18
        backgroundColor = .secondarySystemBackground
    }
 
    // MARK: - Actions
    @objc private func wikipediaButtonTapped() {
        guard let rocket = rocket else { return }
        delegate?.didTapWikipediaButton(for: rocket)
    }
}

extension SPXRocketSpecsView: ViewCode {
    
    func setupComponents() {
        addSubviews(companyLabel, countryLabel, diameterItem, heightItem, massItem, wikipediaButton)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            companyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            companyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            companyLabel.heightAnchor.constraint(equalToConstant: 22),
            
            countryLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: padding),
            countryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countryLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
        
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
            
            wikipediaButton.topAnchor.constraint(equalTo: diameterItem.bottomAnchor, constant: 48),
            wikipediaButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            wikipediaButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            wikipediaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupExtraConfiguration() {
        guard let rocket = rocket else { return }
        
        companyLabel.text = "Company: \(rocket.company)"
        countryLabel.text = "Country: \(rocket.country)"
        heightItem.set(itemInfoType: .height, withValue: rocket.height)
        diameterItem.set(itemInfoType: .diameter, withValue: rocket.diameter)
        massItem.set(itemInfoType: .mass, withValue: Float(rocket.mass))
        
        wikipediaButton.addTarget(self, action: #selector(wikipediaButtonTapped), for: .touchUpInside)
    }
}

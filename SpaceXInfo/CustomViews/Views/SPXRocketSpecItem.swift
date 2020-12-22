//
//  SPXRocketSpecItem.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 21/12/20.
//

import UIKit

enum ItemInfoType {
    case height, diameter, mass
}

class SPXRocketSpecItem: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = SPXTitleLabel(textAlignment: .center, fontSize: 14)
    let valueLabel = SPXSecondaryTitleLabel(fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(symbolImageView, titleLabel, valueLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        valueLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withValue value: Float) {
        switch itemInfoType {
        case .height:
            symbolImageView.image = SFSymbols.height
            titleLabel.text = "Height"
            valueLabel.text = "\(value)m"
        case .diameter:
            symbolImageView.image = SFSymbols.diameter
            titleLabel.text = "Diameter"
            valueLabel.text = "\(value)m"
        case .mass:
            symbolImageView.image = SFSymbols.mass
            titleLabel.text = "Mass"
            valueLabel.text = "\(value)kg"
        }
    }
}

//
//  SPXUpcomingLaunchInfoView.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 12/01/21.
//

import UIKit

class SPXUpcomingLaunchInfoView: UIView {
    
    let patchImageView = SPXAvatarImageView(frame: .zero)
    let nameLabel = SPXTitleLabel(textAlignment: .center, fontSize: 34)
    let dateLabel = SPXSecondaryTitleLabel(fontSize: 18)
    let detailsLabel = SPXBodyLabel(textAlignment: .left)
    
    let padding: CGFloat = 8
    let imagePadding: CGFloat = 36
    
    var launch: Launch!
    
    init(launch: Launch) {
        super.init(frame: .zero)
        self.launch = launch
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(patchImageView)
        configurePatchImageView()
    }
    
    private func configurePatchImageView() {
        if let largePatchURL = launch.largePatchURL {
            patchImageView.downloadImage(fromURL: largePatchURL)
        }
        
        NSLayoutConstraint.activate([
            patchImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: imagePadding),
            patchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            patchImageView.widthAnchor.constraint(equalToConstant: 120),
            patchImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}

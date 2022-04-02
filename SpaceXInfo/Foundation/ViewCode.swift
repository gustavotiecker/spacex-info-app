//
//  ViewCode.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 02/04/22.
//

import Foundation

protocol ViewCode {
    func setupViewCode()
    func setupComponents()
    func setupConstraints()
    func setupExtraConfiguration()
}

extension ViewCode {
    func setupViewCode() {
        setupComponents()
        setupConstraints()
        setupExtraConfiguration()
    }

    func setupExtraConfiguration() {}
}

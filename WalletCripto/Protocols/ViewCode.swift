//
//  ViewCode.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation

protocol ViewCode {
    func applyStyle()
    func setupHierarchy()
    func setupContraints()
}

extension ViewCode {
    func applyStyle() {
        setupHierarchy()
        setupContraints()
    }
}


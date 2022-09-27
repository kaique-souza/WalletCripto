//
//  WalletLabel.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation


import Foundation
import UIKit

class WalletLabel: UILabel {

    init(color: UIColor? = UIColor.gray) {
        super.init(frame: .zero)
        self.Color = color
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var Color: UIColor! {
        didSet {
            applyStyle()
        }
    }

    func applyStyle() {
        font = UIFont(descriptor: UIFontDescriptor(name: "Avenir-Black", size: 18.0), size: 18.0)
        textColor = Color
    }
}


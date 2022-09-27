//
//  WalletView.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import UIKit

class WalletView : UIView {
    var title = ""
    var mensgaem = ""

    init(_ title: String, _ mensagem: String) {
        super.init(frame: .zero)
        self.title =  title
        self.mensgaem = mensagem
        applyStyle()
        setupHierarchy()
        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var lblTitle: WalletLabel = {
        var label = WalletLabel()
        label.text = title
        label.numberOfLines = 0
        label.tintColor = UIColor.black
        return label
    }()

    lazy var lblMensagem: WalletLabel = {
        var label = WalletLabel()
        label.text = mensgaem
        label.numberOfLines = 0
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Avenir-Normal", size: 18.0), size: 18.0)
        return label
    }()

    lazy var image: UIImageView = {
        let image = UIImage(named: "right-arrow")
        let view = UIImageView(image: image)

        return view
    }()

    func applyStyle() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor


        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
}

extension WalletView: ViewCode {
    func setupHierarchy() {
        addSubview(lblTitle)
        addSubview(lblMensagem)
        addSubview(image)
    }

    func setupContraints() {
        self.lblTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }

        self.lblMensagem.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
        }

        self.image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}

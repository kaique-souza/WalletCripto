//
//  LoginViewScreen.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import UIKit
import SnapKit

protocol LoginViewScreenDelegate {
    func didTapEntrar()
}

class LoginViewScreen: UIView {
    //MARK: - Properties
    var delegate: LoginViewScreenDelegate?

    //MARK: - Constructor
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Components
    lazy var viewBase: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var titleApp: WalletLabel = {
        var label = WalletLabel()
        label.text = "Wallet Cripto"
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Avenir-Black", size: 35.0), size: 35.0)
        label.textColor = UIColor.yellow
        return label
    }()

    lazy var lblUser: WalletLabel = {
        var label = WalletLabel()
        label.text = "Usuário:"
        return label
    }()

    lazy var textUser: WalletTextField = {
        var text = WalletTextField()
        return text
    }()

    lazy var lblSenha: WalletLabel = {
        var label = WalletLabel()
        label.text = "Senha:"
        return label
    }()

    lazy var textSenha: WalletTextField = {
        var text = WalletTextField()
        text.isSecureTextEntry = true
        return text
    }()

    lazy var lblEsqueceuSenha: WalletLabel = {
        var label = WalletLabel()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.font : UIFont(name: "Avenir-Medium", size: 18.0)!, NSAttributedString.Key.foregroundColor : UIColor.darkGray] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: "Esqueci minha senha.", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()

    lazy var buttonLogin: UIButton = {
        var button = UIButton()
        button.setTitle("Entrar", for: .normal)
        button.tintColor = UIColor.darkGray
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapEntrar), for: .touchUpInside)
        return button
    }()

    //MARK: - Methods
    func setupView() {
        applyStyle()
        self.backgroundColor = .black
    }

    @objc func didTapEntrar() {
        delegate?.didTapEntrar()
    }
}

extension LoginViewScreen: ViewCode {

    //MARK: - Hierarch
    func setupHierarchy() {
        addSubview(titleApp)
        viewBase.addSubview(lblUser)
        viewBase.addSubview(textUser)
        viewBase.addSubview(lblSenha)
        viewBase.addSubview(textSenha)
        viewBase.addSubview(buttonLogin)
        viewBase.addSubview(lblEsqueceuSenha)
        addSubview(viewBase)
    }

    //MARK: - Constraints
    func setupContraints() {
        self.titleApp.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.bottom).inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalTo(250)
        }

        self.lblUser.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        self.textUser.snp.makeConstraints { make in
            make.top.equalTo(lblUser.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        self.lblSenha.snp.makeConstraints { make in
            make.top.equalTo(textUser.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        self.textSenha.snp.makeConstraints { make in
            make.top.equalTo(lblSenha.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        self.buttonLogin.snp.makeConstraints { make in
            make.top.equalTo(textSenha.snp.bottom).inset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(30)
//            make.width.equalTo(200)
        }

        self.lblEsqueceuSenha.snp.makeConstraints { make in
            make.top.equalTo(buttonLogin.snp.bottom).inset(-15)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }

        self.viewBase.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-30)
        }
    }
}

//
//  LoginViewController.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import UIKit

class LoginViewController: UIViewController {

    var viewScreen: LoginViewScreen!

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViewController()
        }

        override func viewWillAppear(_ animated: Bool) {
            
        }

        func setupViewController() {
            title = " "
            viewScreen = LoginViewScreen()
            viewScreen?.delegate = self
            guard let _ = viewScreen else { return }
            view.addSubview(viewScreen)

            self.viewScreen.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }

}


extension LoginViewController: LoginViewScreenDelegate {
    func didTapEntrar() {
        let vc = Coordinators(tela: .Home).getTela()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

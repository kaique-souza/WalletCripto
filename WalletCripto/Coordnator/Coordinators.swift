//
//  Coordinators.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import SwiftUI

internal enum Telas {
    case Login
    case Home
    case Lista
    case Simulacao
}

class Coordinators {

    private var Scene: Telas = .Login

    init(tela: Telas) {
        self.Scene = tela
    }

    public func getTela() -> UIViewController {
        switch Scene {
        case .Login:
            return LoginViewController()
        case .Home:
            return HomeViewController()
        case .Lista:
            return ListaViewController()
        case .Simulacao:
            return SimulacaoViewController()
        }
    }
}

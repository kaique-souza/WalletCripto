//
//  HomeViewScreen.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import UIKit
import SnapKit

protocol HomeViewScreenDelegate {
    func tapCotacao()
    func tapSimulacao()
    func tapFavoritas()
}

class HomeViewScreen : UIView {
    //MARK: - Properties
    var delegate: HomeViewScreenDelegate?

    //MARK: - Constructors
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = UIColor.lightGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Components
    lazy var title: WalletLabel = {
        var label = WalletLabel(color: UIColor.black)
        label.text = "Bem vindo! Acompanhe e gerencie suas criptos de forma facil e agil."
        label.font = UIFont(name: "Avenir-Black", size: 25.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var viewCotacao : WalletView = {
        var view = WalletView("Cotação", "Acompanhe a cotação de suas criptomoedas.")
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapCotacao))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var viewSimulacao : WalletView = {
        var view = WalletView("Simulação de lucros", "Simule seus ganhos ou perdas com base na cotação atual.")
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapSimulacao))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var viewFavoritas : WalletView = {
        var view = WalletView("Favoritas", "Acompanhe sua lista de criptos favoritas.")
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapFavoritas))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var collection: UICollectionViewFlowLayout = {
        var collection = UICollectionViewFlowLayout()
//        let flowLayout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        collection.scrollDirection = .vertical
        return collection
    }()

    @objc func tapCotacao() {
        self.delegate?.tapCotacao()
    }

    @objc func tapSimulacao() {
        self.delegate?.tapSimulacao()
    }

    @objc func tapFavoritas() {
        self.delegate?.tapFavoritas()
    }

    func setupView() {
        setupHierarchy()
        setupContraints()
    }
}

extension HomeViewScreen : ViewCode {
    func setupHierarchy() {
        addSubview(title)
        addSubview(viewCotacao)
        addSubview(viewSimulacao)
        addSubview(viewFavoritas)
    }

    func setupContraints() {

        self.title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(15)
        }

        self.viewCotacao.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }

        self.viewSimulacao.snp.makeConstraints { make in
            make.top.equalTo(viewCotacao.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }

        self.viewFavoritas.snp.makeConstraints { make in
            make.top.equalTo(viewSimulacao.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }
    }
}

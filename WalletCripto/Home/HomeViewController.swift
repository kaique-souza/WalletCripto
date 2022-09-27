//
//  HomeViewController.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var viewScreen: HomeViewScreen!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }

    func setupView() {
        title = "Inicio"
        view.backgroundColor = UIColor.white

        viewScreen = HomeViewScreen()
        viewScreen?.delegate = self
        guard let _ = viewScreen else { return }
        view.addSubview(viewScreen)

        self.viewScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}


extension HomeViewController: ViewCode {
    func setupHierarchy() {

    }

    func setupContraints() {
        self.viewScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController : HomeViewScreenDelegate {
    func tapSimulacao() {
        let vc = Coordinators(tela: .Simulacao).getTela()
        navigationController?.pushViewController(vc, animated: true)
    }

    func tapFavoritas() {

    }

    func tapCotacao() {
        let vc = Coordinators(tela: .Lista).getTela()
        navigationController?.pushViewController(vc, animated: true)
    }


}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }


}

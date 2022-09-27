//
//  HomeViewController.swift
//  criptoNotes
//
//  Created by kaique souza on 25/11/21.
//

import UIKit
import SnapKit
import Alamofire

struct Like {
    var isLike: Bool
}

class ListaViewController: UIViewController {
    var screen: ListaViewScreen?
    var listaDeCriptos: Array<ListaModel.Datum> = []
    let req = ListaViewModel()
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        let headers : HTTPHeaders = ["X-CMC_PRO_API_KEY" : "3d488cd5-b765-482e-88a8-52a2779272c3"]
        req.requestAPI(endPoint: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest", method: .get, header: headers) { response in
            switch response {
            case .success(let value):
                self.listaDeCriptos = value
            case .failure(let error):
                print(error)
            }
            self.setupView()
        }
    }

    func setupView() {
        self.screen = ListaViewScreen()
        guard let viewScreen = self.screen else { return }
        viewScreen.tableView.delegate = self
        viewScreen.tableView.dataSource = self
        view.addSubview(viewScreen)
        viewScreen.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}

extension ListaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaDeCriptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = ListaTableViewCell()
        let moeda = self.listaDeCriptos[indexPath.row]
        celula.setNome(moeda)
        return celula
    }
    
}

//
//  SimulacaoViewController.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import UIKit
import SnapKit
import Alamofire

protocol CallbackService {
    func setValue(_ result: SimulacaoModel.Datum)
}

internal class SimulacaoViewController: UIViewController {

    let viewScreen = SimulacaoViewScreen()
    let ViewModel = SimulacaoViewlModel()
    var delegate: CallbackService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Simulação de Resultados"
        viewScreen.delegate = self
        delegate = viewScreen
        view.addSubview(viewScreen)
        self.viewScreen.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}

extension SimulacaoViewController: SimulacaoViewScreenDelegate {
    func showAlert() {
        let alert = UIAlertController(title: "Erro ao enviar dados.", message: "Por gentileza, preencher todos os campos!", preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(button)
        navigationController?.present(alert, animated: true, completion: nil)
    }

    func didTapCalcular(_ symbol: String, _ amount: String) {
        let headers : HTTPHeaders = ["X-CMC_PRO_API_KEY" : "3d488cd5-b765-482e-88a8-52a2779272c3"]
        ViewModel.requestAPI(endPoint: "https://pro-api.coinmarketcap.com/v1/tools/price-conversion?amount=\(amount)&symbol=\(symbol)&convert=BRL", method: .get, header: headers) { response in
            switch response {
            case .success(let value):
                self.delegate?.setValue(value)
            case .failure:
                let alert = UIAlertController(title: "Ops! tivemos um problema!", message: "Por gentileza, tente novamente mais tarde!", preferredStyle: .alert)
                let button = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(button)
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
        }
    }

}

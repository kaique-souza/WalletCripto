//
//  SimulacaoViewModel.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation
import Alamofire

internal class SimulacaoViewlModel {
    public func requestAPI(endPoint: String, method: HTTPMethod, header: HTTPHeaders, completion: @escaping(Result<SimulacaoModel.Datum, Error>) -> Void) {
       AF.request(endPoint, method: method, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let dicionario = value as? Dictionary<String, Any> else { return }
                guard let data =  self.converteDicinario(json: dicionario) else { return }
                guard let conversao =  self.decodificar(jsonData: data) else { return }
                completion(.success(conversao))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func converteDicinario(json: Dictionary<String, Any>)-> Data? {
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }

    private func decodificar(jsonData: Data)-> SimulacaoModel.Datum? {
        do{
            let listaPopulada = try JSONDecoder().decode(SimulacaoModel.Datum.self, from: jsonData)
            return listaPopulada
        } catch {
            print(String(describing: error))
            return nil
        }
    }
}

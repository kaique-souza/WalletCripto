//
//  HomeWorker.swift
//  criptoNotes
//
//  Created by kaique souza on 25/11/21.
//

import Foundation
import Alamofire

class ListaViewModel {
    func requestAPI(endPoint: String, method: HTTPMethod, header: HTTPHeaders, completion: @escaping(Result<[ListaModel.Datum], Error>) -> Void) {
//        let headers :HTTPHeaders = ["X-CMC_PRO_API_KEY" : "3d488cd5-b765-482e-88a8-52a2779272c3"]
       AF.request(endPoint, method: method, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else { return }
                guard let dicionario = json["data"] as? Array<Dictionary<String, Any>> else { return }
                guard let data =  self.converteDicinario(json: dicionario) else { return }
                guard let listaMoeda =  self.decodificar(jsonData: data) else { return }
                completion(.success(listaMoeda))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func converteDicinario(json: [[String:Any]])-> Data? {
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    func decodificar(jsonData: Data)-> [ListaModel.Datum]?{
        do{
            let listaPopulada = try JSONDecoder().decode([ListaModel.Datum].self, from: jsonData)
            return listaPopulada
        }catch{
            print(String(describing: error))
            return nil
        }
    }
}


//"https://pro-api.coinmarketcap.com/v1/tools/price-conversion?amount=1&symbol=BTC&convert=XRP" ****Endpoind de conversao

//
//  SimulacaoModel.swift
//  WalletCripto
//
//  Created by kaique souza on 26/09/22.
//

import Foundation

internal enum SimulacaoModel {

    // MARK: - Welcome
    struct Datum: Codable {
        let status: Status?
        let data: DataClass
    }

    // MARK: - DataClass
    struct DataClass: Codable {
        let id: Int
        let symbol, name: String
        let amount: Int
        let quote: Quote

        enum CodingKeys: String, CodingKey {
            case id, symbol, name, amount
            case quote
        }
    }

    // MARK: - Quote
    struct Quote: Codable {
        let brl: Brl

        enum CodingKeys: String, CodingKey {
            case brl = "BRL"
        }
    }

    // MARK: - Brl
    struct Brl: Codable {
        let price: Double

        enum CodingKeys: String, CodingKey {
            case price
        }
    }

    // MARK: - Status
    struct Status: Codable {
        let timestamp: String?
        let elapsed: Int?

        enum CodingKeys: String, CodingKey {
            case timestamp
            case elapsed
        }
    }
}

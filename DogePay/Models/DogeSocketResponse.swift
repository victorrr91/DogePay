//
//  DogeSocketResponse.swift
//  DogePay
//
//  Created by Victor Lee on 2023/03/10.
//

import Foundation

struct SocketResponse: Codable {
    let op: String?
    let msg: Msg?

    enum CodingKeys: String, CodingKey {
        case op
        case msg = "x"
    }
}

struct Msg: Codable {
    let type, value, exchangeName, priceBase: String?

    enum CodingKeys: String, CodingKey {
        case type, value
        case exchangeName = "exchange_name"
        case priceBase = "price_base"
    }
}

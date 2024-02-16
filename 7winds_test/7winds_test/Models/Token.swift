//
//  Token.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 12.02.2024.
//

import Foundation

struct Token: Decodable {
    let token: String
    let tokenLifetime: Int
}

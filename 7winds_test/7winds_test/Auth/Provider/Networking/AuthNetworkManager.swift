//
//  AuthNetworkManager.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 12.02.2024.
//

import Foundation

struct AuthNetworkManager {
    private let networkService = NetworkService<AuthAPI>()
    func getAccessToken(userInfo: AuthModel, completion: @escaping RequestResult<Token>) {
        networkService.sendRequest(.auth(userInfo), port: .userService, type: Token.self) { result in
            completion(result)
        }
    }
}

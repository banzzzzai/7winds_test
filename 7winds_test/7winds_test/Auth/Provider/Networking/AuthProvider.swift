//
//  AuthProvider.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 12.02.2024.
//

import Foundation

protocol ProvidesAuth: AnyObject {
    func fetchAuthorizationToken(usersCredentional: AuthModel, completion: @escaping RequestResult<Token>)
}

final class AuthProvider {
    private let networkManager: AuthNetworkManager
    
    init(
        networkManager: AuthNetworkManager
    ) {
        self.networkManager = networkManager
    }
}

extension AuthProvider: ProvidesAuth {
    func fetchAuthorizationToken(usersCredentional: AuthModel, completion: @escaping RequestResult<Token>) {
        networkManager.getAccessToken(userInfo: usersCredentional) { completion($0) }
    }
}

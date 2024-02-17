//
//  AuthInteractor.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//  
//

import Foundation

protocol AuthInteractorProtocol: AnyObject {
    func login(login: String, password: String)
    func register(login: String, password: String)
}

final class AuthInteractor {
    
    // MARK: - Properties
    weak var presenter: InteractorOutputProtocol?
    private var provider: ProvidesAuth
    private var keychainManager: KeychainManagerProtocol
    
    // MARK: - Init
    init(provider: ProvidesAuth, keychainManager: KeychainManagerProtocol) {
        self.provider = provider
        self.keychainManager = keychainManager
    }
    
}

// MARK: - AuthInteractorProtocol
extension AuthInteractor: AuthInteractorProtocol {
    func login(login: String, password: String) {
        let user = AuthModel(login: login, password: password)
        provider.fetchAuthorizationToken(usersCredentional: user) { [self] result in
            switch result {
            case .success(let token):
                keychainManager.save(item: token?.token, service: .token)
                keychainManager.save(item: Int(NSDate().timeIntervalSince1970) + (token?.tokenLifetime ?? 0), service: .tokenExpirationDate)
                presenter?.authSuccess()
            case .failure(let error):
                presenter?.networkError(error: error)
            }
            
        }
    }
    
    func register(login: String, password: String) {
        
    }
    
}

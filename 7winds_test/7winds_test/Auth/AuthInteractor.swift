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
    weak var presenter: AuthPresenterProtocol?
    private var provider: ProvidesAuth
    
    // MARK: - Init
    init(provider: ProvidesAuth) {
        self.provider = provider
    }
    
}

// MARK: - AuthInteractorProtocol
extension AuthInteractor: AuthInteractorProtocol {
    func login(login: String, password: String) {
        let user = AuthModel(login: login, password: password)
        provider.fetchAuthorizationToken(usersCredentional: user) { result in
            switch result {
            case .success(let token):
                // TODO: - сохранить токен и время его истечения
                print(token?.token)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func register(login: String, password: String) {
        
    }
    
}

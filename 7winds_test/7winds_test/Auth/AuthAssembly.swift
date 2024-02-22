//
//  AuthAssembly.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//  
//

final class AuthAssembly {
    static func build() -> AuthViewController {
        let viewController = AuthViewController()
        let networkManager = AuthNetworkManager()
        let provider = AuthProvider(networkManager: networkManager)
        let keychainManager = KeychainManager.shared
        let interactor = AuthInteractor(provider: provider, keychainManager: keychainManager)
        let router = AuthRouter()
        let presenter = AuthPresenter(interactor: interactor, router: router)

        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}


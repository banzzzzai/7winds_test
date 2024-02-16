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
        let networkManager = NetworkManager()
        let provider = AuthProvider(networkManager: AuthNetworkManager())
        let interactor = AuthInteractor(provider: provider)
        let router = AuthRouter()

        let presenter =  AuthPresenter(
            interactor: interactor,
            router: router
        )

        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return viewController
    }
}


//
//  NearestCoffeeAssembly.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

final class NearestCoffeeAssembly {
    static func build() -> NearestCoffeeViewController {
        let viewController = NearestCoffeeViewController()
        let networkManager = NearestCoffeeNetworkManager()
        let provider = NearestCoffeeProvider(networkManager: networkManager)
        let keychainManager = KeychainManager.shared
        let interactor = NearestCoffeeInteractor(provider: provider, keychainManager: keychainManager)
        let router = NearestCoffeeRouter()
        let presenter = NearestCoffeePresenter(interactor: interactor, router: router)
        
        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}

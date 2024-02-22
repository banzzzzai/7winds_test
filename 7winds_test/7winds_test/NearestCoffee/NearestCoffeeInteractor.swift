//
//  NearestCoffeeInteractor.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

import Foundation

protocol NearestCoffeeInteractorProtocol: AnyObject {
    
}

final class NearestCoffeeInteractor {
    
    // MARK: - Properties
    weak var presenter: NearestCoffeePresenterProtocol?
    private var provider: ProvidesNearestCoffee
    private var keychainManager: KeychainManagerProtocol
    
    init
    (
        provider: ProvidesNearestCoffee,
        keychainManager: KeychainManagerProtocol) 
    {
        self.provider = provider
        self.keychainManager = keychainManager
    }
    
}

// MARK: - NearestCoffeeInteractorProtocol
extension NearestCoffeeInteractor: NearestCoffeeInteractorProtocol {
    
}

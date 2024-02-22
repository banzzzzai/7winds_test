//
//  NearestCoffeeProvider.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

import Foundation

protocol ProvidesNearestCoffee: AnyObject {
    
}

final class NearestCoffeeProvider {
    
    private let networkManager: NearestCoffeeNetworkManager
    
    init(networkManager: NearestCoffeeNetworkManager) {
        self.networkManager = networkManager
    }
    
}

 // MARK: - ProvidesNearestCoffee
extension NearestCoffeeProvider: ProvidesNearestCoffee {
    
}

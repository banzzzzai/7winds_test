//
//  NearestCoffeeRouter.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

import Foundation

protocol NearestCoffeeRouterProtocol: AnyObject {
    
}

final class NearestCoffeeRouter {
    
    // MARK: - Properties
    weak var viewController: NearestCoffeeViewController?
    
}

// MARK: - NearestCoffeeRouterProtocol
extension NearestCoffeeRouter: NearestCoffeeRouterProtocol {
    
}

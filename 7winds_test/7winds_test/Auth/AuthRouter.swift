//
//  AuthRouter.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import Foundation

protocol AuthRouterProtocol: AnyObject {
    func showNextSreen()
}

class AuthRouter {
    
    // MARK: - Properties
    weak var viewController: AuthViewController?
    
}

// MARK: - AuthRouterProtocol
extension AuthRouter: AuthRouterProtocol {
    func showNextSreen() {
        let nextVC = NearestCoffeeAssembly.build()
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

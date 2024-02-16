//
//  AuthRouter.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import Foundation

protocol AuthRouterProtocol: AnyObject {
    
}

class AuthRouter {
    
    // MARK: - Properties
    weak var presenter: AuthPresenterProtocol?
    
}

extension AuthRouter: AuthRouterProtocol {
    
}

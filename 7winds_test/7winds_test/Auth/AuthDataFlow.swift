//
//  AuthDataFlow.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

enum AuthDataFlow {
    
    struct ViewModel {
        
        struct AuthViewModel {
            let emailLabel: String
            let passwordLabel: String
            let repeatPasswordLabel: String
            let haveAccountText: String
            let loginPlaceholderText: String
            let passwordPlaceholderText: String
            var signUpInBtn: DefaultButtonModel
            var authBtn: DefaultButtonModel
        }
        
        struct ChangeStateViewModel {
            let haveAccountText: String
            let signUpInBtnLabel: String
            let authBtnLabel: String
        }
        
        struct AlertViewModel {
            let title: String
            let message: String
        }
        
    }
    
    struct Response {
        var state: AuthState?
        var alertTitle: String?
        var alertMessage: String?
    }
    
}

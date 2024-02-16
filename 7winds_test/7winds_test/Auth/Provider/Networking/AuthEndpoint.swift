//
//  AuthEndpoint.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 12.02.2024.
//

import Foundation

enum AuthAPI {
    case auth(AuthModel)
}

extension AuthAPI: EndPointType {
    static let endpoint = "/auth/"
    
    var path: String {
        switch self {
        case .auth:
            return AuthAPI.endpoint + "login"
        }
    }
    
    var httpMethod: HTTPMethod {
        .post
    }
    
    var task: HTTPTask {
        switch self {
        case .auth(let user):
            return .requestParametersAndHeaders(
                bodyParameters: [
                    "login": user.login,
                    "password": user.password
                ],
                urlParameters: nil,
                additionHeaders: ["Is-Web-Request": "false"]
            )
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

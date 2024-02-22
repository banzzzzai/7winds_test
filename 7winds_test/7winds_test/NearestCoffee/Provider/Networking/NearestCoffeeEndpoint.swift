//
//  NearestCoffeeEndpoint.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

import Foundation

enum NearestCoffeeAPI {
    case getNearestCoffee(NearestCoffeeModel)
}

extension NearestCoffeeAPI: EndPointType {
    static let endpoint = "/locations/"
    
    var path: String {
        switch self {
        case .getNearestCoffee:
            return NearestCoffeeAPI.endpoint
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getNearestCoffee(let userLocation):
            // MARK: - в апи не реализован метод подбора ближайших кофейнь
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

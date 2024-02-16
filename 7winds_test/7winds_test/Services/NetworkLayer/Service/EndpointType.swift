//
//  EndpointType.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum EndPointAPI {
    static let scheme = "http"
    static let hostURL = "147.78.66.203"
    static let port = 3210
}

enum EndpointPort: Int {
    case userService = 3210
}

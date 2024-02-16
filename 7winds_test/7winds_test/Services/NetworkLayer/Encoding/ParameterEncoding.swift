//
//  ParameterEncoding.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

enum NetworkError: String, CustomNSError {
    case successfulConnection = "Successful connection"
    case connectionFailed = "No internet connection"
    case redirection = "Redirection"
    case encodingFailed = "Parameters encoding failed"
    case missingUrl = "URL is nil"
    case serverError = "Server errors"
    case clientError = "Client error with connection"
    
    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: self.rawValue]
    }
}

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

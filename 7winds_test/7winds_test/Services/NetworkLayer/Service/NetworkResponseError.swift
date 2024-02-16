//
//  NetworkResponseError.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

enum NetworkResponse: String, Error {
    case ok = "Ok"
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

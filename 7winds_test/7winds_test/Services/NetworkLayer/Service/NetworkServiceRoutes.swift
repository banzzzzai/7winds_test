//
//  NetworkServiceRoutes.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

typealias RequestResult<Type> = ((Result<Type?, NetworkError>) -> Void)

protocol NetworkServiceRoutes: AnyObject {
    associatedtype EndPoint: EndPointType

    func sendRequest<T: Decodable>(_ route: EndPoint, port: EndpointPort, type: T.Type, completion: @escaping RequestResult<T>)
}

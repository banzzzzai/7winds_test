//
//  NetworkManager.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func authRequest(url: String, parameters: AuthModel, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func authRequest(url: String, parameters: AuthModel, completion: @escaping (Result<Data, Error>) -> Void) {
        print("Requested auth: \(parameters.login) - \(parameters.password)")
        AF.request(url, method: .post, parameters: parameters).response { response in
            switch response.result {
            case .success(let data):
                do {
                    guard let data else { return }
                    let _ = try JSONSerialization.jsonObject(with: data)
                    completion(.success(data))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

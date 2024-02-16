//
//  NetworkService.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

final class NetworkService<EndPoint: EndPointType>: NetworkServiceRoutes {
    private var task: URLSessionTask?

    func sendRequest<T: Decodable>(_ route: EndPoint, port: EndpointPort, type: T.Type, completion: @escaping RequestResult<T>) {
        let session = URLSession.shared

        do {
            guard let request = try self.buildRequest(from: route, port: port) else { return }
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        completion(.failure(NetworkError.connectionFailed))
                        return
                    }
            
                    guard let response = response as? HTTPURLResponse else { return }
                    switch response.statusCode {
                    case 200..<299:
                        guard let data = self.jsonDecode(type: type.self, from: data) else {
                            completion(.success(nil))
                            return
                        }
                        completion(.success(data))
                    case 300..<399:
                        completion(.failure(NetworkError.redirection))
                    case 400..<499:
                        completion(.failure(NetworkError.clientError))
                    case 500..<599:
                        completion(.failure(NetworkError.serverError))
                    default:
                        completion(.failure(NetworkError.connectionFailed))
                    }
                    
                }
            })
        } catch {
            DispatchQueue.main.async {
                print(error.localizedDescription)
                completion(.failure(error as! NetworkError))
            }
        }
            self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}

private extension NetworkService {
    func buildRequest(from route: EndPoint, port: EndpointPort) throws -> URLRequest? {
        guard let url = configureURL(route: route, port: port) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(
                let bodyParameters,
                let urlParameters
            ):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
//            case .accountImageUploadingParameters:
//                break
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureURL(route: EndPoint, port: EndpointPort) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = EndPointAPI.scheme
        urlComponents.host = EndPointAPI.hostURL
        urlComponents.port = port.rawValue
        urlComponents.path = route.path
        return urlComponents.url
    }
    
    func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func jsonDecode<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard
            let data = data,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        
        return response
    }
}

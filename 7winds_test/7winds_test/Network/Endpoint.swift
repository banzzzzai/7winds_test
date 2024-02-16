//
//  Endpoint.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import Foundation

struct EndPoint {
    var path: String
    var url: String {
        let base_url = "http://185.244.172.108:3210"
        return base_url + path
    }
}

// MARK: - Methods
extension EndPoint {
    
    static var register: String {
        EndPoint(path: "/auth/register").url
    }
    
    static var login: String {
        EndPoint(path: "/auth/login").url
    }
    
}

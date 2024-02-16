//
//  KeychainManager.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 14.02.2024.
//

import Foundation

protocol KeychainManagerProtocol {
    func save<T: Codable>(item: T, service: KeychainManager.ServiceKeys)
    func read<T: Codable>(service: KeychainManager.ServiceKeys, type: T.Type) -> T?
    func deleteItem(service: KeychainManager.ServiceKeys)
    
}

class KeychainManager: KeychainManagerProtocol {
    
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static let shared: KeychainManagerProtocol = KeychainManager()
    
    private init () { }
    
    func save<T: Codable>(item: T, service: ServiceKeys) {
        do {
            let data = try JSONEncoder().encode(item)
            let query = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service.rawValue as AnyObject,
//                kSecAttrAccount as String: Constants.account as AnyObject,
                kSecValueData as String: data as AnyObject,
            ] as CFDictionary
            
            var status = SecItemAdd(query, nil)
            
            if status == errSecDuplicateItem {
                deleteItem(service: service)
            }
            status = SecItemAdd(query, nil)
            guard status == errSecSuccess else {
                return
            }
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T: Codable>(service: ServiceKeys, type: T.Type) -> T? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service.rawValue as AnyObject,
//            kSecAttrAccount as String: Constants.account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let _ = SecItemCopyMatching(query as CFDictionary, &result)
        do {
            guard let data = result as? Data else { return nil }
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func deleteItem(service: ServiceKeys) {
        let query = [
            kSecAttrService: service.rawValue,
//            kSecAttrAccount: Constants.account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
    
        SecItemDelete(query)
    }
}

extension KeychainManager {
    enum ServiceKeys: String {
        case token
    }
}

private extension KeychainManager {
    enum Constants {
        
    }
}

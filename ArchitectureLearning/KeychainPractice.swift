//
//  KeychainPractice.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/18/25.
//

import Foundation

enum KeychainError: Error {
    case duplicateItem
    case unknown(status: OSStatus)
}

final class KeychainManager {
    static func save(password: Data, account: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return "Saved"
        
    }
    
    static func getPassword(for account: String) throws -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status: status)
        }
        
        return result as? Data
    }
}

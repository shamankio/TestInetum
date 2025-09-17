//
//  DomainError.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

enum DomainError: Error {
    case invalidPostcode
    case salesmenNotFound
    case networkError(String)
    
    public var errorDescription: String? {
        switch self {
            case .invalidPostcode:
                return "Invalid postcode format"
            case .salesmenNotFound:
                return "No salesmen found"
            case .networkError(let message):
                return "Network error: \(message)"
        }
    }
    //TODO: add more cases. For example invalidData
}

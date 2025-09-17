//
//  PostcodeExpression.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

struct PostcodeExpression: Equatable {
    private let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    public var isWildcard: Bool {
        value.hasSuffix("*")
    }
    
    public var prefix: String {
        isWildcard ? String(value.dropLast()) : value
    }
    
    public func canHandle(searchQuery: String) -> Bool {
        guard !value.isEmpty, !searchQuery.isEmpty else { return false }
        
        if searchQuery.hasSuffix("*") {
            let searchPrefix = String(searchQuery.dropLast())
            guard searchPrefix.allSatisfy(\.isNumber) else { return false }
            
            if isWildcard {
                let areaPrefix = self.prefix
                return areaPrefix.hasPrefix(searchPrefix)
            } else {
                // If this area is exact (e.g., "76200")
                // Area can handle search if area starts with search prefix
                // e.g., area "76200" can handle search "762*"
                return value.hasPrefix(searchPrefix)
            }
        } else {
            if isWildcard {
                let prefix = self.prefix
                guard prefix.allSatisfy(\.isNumber) else { return false }
                // Area can handle search if search starts with area prefix
                // e.g., area "762*" can handle search "76200"
                return searchQuery.hasPrefix(prefix)
            } else {
                // Both are exact - must match exactly
                return value == searchQuery
            }
        }
    }
}

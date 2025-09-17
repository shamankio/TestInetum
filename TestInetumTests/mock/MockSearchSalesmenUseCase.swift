//
//  MockSearchSalesmenUseCase.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation
@testable import TestInetum

@MainActor
final class MockSearchSalesmenUseCase: SearchSalesmenUseCase {
    var filtered: [Salesman] = []
    
    func execute(postcode: String, salesmen: [Salesman]) -> [Salesman] {
        filtered
    }
}

//
//  MockGetSalesmenUseCase.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation
@testable import TestInetum

@MainActor
final class MockGetSalesmenUseCase: GetSalesmenUseCase {
    var result: Result<[Salesman], DomainError> = .success([])

    func execute() async throws -> Result<[Salesman], DomainError> {
        result
    }
}

//
//  MockSalesmanAPI.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation
@testable import TestInetum

class FakeSalesmanAPISuccess: SalesmanAPI {
    func fetchSalesmenData() async throws -> [SalesmanDTO] {
        return [
            SalesmanDTO(name: "Artem Titarenko", areas: ["76133"]),
            SalesmanDTO(name: "Bernd Schmitt", areas: ["7619*"])
        ]
    }
}

class FakeSalesmanAPIFailure: SalesmanAPI {
    enum TestError: Error { case failed }
    
    func fetchSalesmenData() async throws -> [SalesmanDTO] {
        throw TestError.failed
    }
}
class FakeSalesmanAPIEmpty: SalesmanAPI {
    func fetchSalesmenData() async throws -> [SalesmanDTO] {
        return []
    }
}

//
//  SalesmanRepositoryTests.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Testing

@testable import TestInetum

@MainActor
struct SalesmanRepositoryTests {

    @Test("Repository returns salesmen when API succeeds")
    func testRepositorySuccess() async throws {
        // Given
        let repository = SalesmanRepositoryImplement(
            api: FakeSalesmanAPISuccess()
        )
        // When
        let result = await repository.getAllSalesmen()
        // Then
        switch result {
        case .success(let salesmen):
            #expect(salesmen.count == 2)
            #expect(salesmen[0].name == "Artem Titarenko")
            #expect(salesmen[1].areas.contains("7619*"))
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }

    @Test("Repository returns failure when API throws error")
    func testRepositoryFailure() async throws {
        // Given
        let repository = SalesmanRepositoryImplement(
            api: FakeSalesmanAPIFailure()
        )
        // When
        let result = await repository.getAllSalesmen()
        // Then
        switch result {
        case .success:
            Issue.record("Expected failure but got success")
        case .failure(let error):
            if case .salesmenNotFound = error {
                #expect(true)
            } else {
                Issue.record("Expected .salesmenNotFound but got \(error)")
            }
        }
    }

    @Test("Repository returns empty list when API has no salesmen")
    func testRepositoryEmpty() async throws {
        // Given
        let repository = SalesmanRepositoryImplement(
            api: FakeSalesmanAPIEmpty()
        )
        // When
        let result = await repository.getAllSalesmen()
        // Then
        switch result {
        case .success(let salesmen):
            #expect(salesmen.isEmpty)
        case .failure:
            Issue.record("Expected success([]) but got failure")
        }
    }

}

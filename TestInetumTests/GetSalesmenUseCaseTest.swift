//
//  GetSalesmenUseCaseTest.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Testing
@testable import TestInetum

@MainActor
struct GetSalesmenUseCaseTest {
    
    @Test("GetSalesmenUseCase returns success with data")
    func testExecuteSuccess() async throws {
        // Given
        let api = FakeSalesmanAPISuccess()
        let repository = SalesmanRepositoryImplement(api: api)
        let useCase = GetSalesmenUseCaseImplement(repository: repository)

        // When
        let result = await useCase.execute()

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

    @Test("GetSalesmenUseCase returns failure when API throws error")
    func testExecuteFailure() async throws {
        // Given
        let api = FakeSalesmanAPIFailure()
        let repository = SalesmanRepositoryImplement(api: api)
        let useCase = GetSalesmenUseCaseImplement(repository: repository)

        // When
        let result = await useCase.execute()

        // Then
        switch result {
        case .failure(let error):
            if case .salesmenNotFound = error {
                #expect(true)
            } else {
                Issue.record("Expected .salesmenNotFound but got \(error)")
            }
        default:
            Issue.record("Expected failure but got success")
        }
    }

}

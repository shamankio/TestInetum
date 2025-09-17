//
//  SearchSalesmenUseCaseTests.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Testing
@testable import TestInetum

@MainActor
struct SearchSalesmenUseCaseTests {
    var useCase: SearchSalesmenUseCase
    var testSalesmen: [Salesman]

    init() {
        // Given
        useCase = SearchSalesmenUseCaseImplement()
        testSalesmen = [
            Salesman(name: "Artem Titarenko", areas: ["76133"]),
            Salesman(name: "Bernd Schmitt", areas: ["7619*"]),
            Salesman(name: "Chris Krapp", areas: ["762*"]),
            Salesman(name: "Alex Uber", areas: ["86*"]),
        ]
    }

    @Test func testEmptySearchReturnsAllSalesmen() {
        // When
        let result = useCase.execute(postcode: "", salesmen: testSalesmen)
        // Then
        #expect(result.count == testSalesmen.count)
    }

    @Test func testExactMatch() {
        // When
        let result = useCase.execute(postcode: "76133", salesmen: testSalesmen)
        // Then
        #expect(result.count == 1)
        #expect(result.first?.name == "Artem Titarenko")
    }

    @Test func testWildcardMatch() {
        // When
        let result = useCase.execute(postcode: "76190", salesmen: testSalesmen)
        let names = result.map { $0.name }.sorted()
        // Then
        #expect(result.count == 1)
        #expect(names == ["Bernd Schmitt"])
    }

    @Test func testNoMatch() {
        let result = useCase.execute(postcode: "99999", salesmen: testSalesmen)
        // Then
        #expect(result.count == 0)
    }

}

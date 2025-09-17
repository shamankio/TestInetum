//
//  SalesmanViewModelTests.swift
//  TestInetumTests
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Testing

@testable import TestInetum
import Foundation

@MainActor
struct SalesmanViewModelTests {
    var mockGet = MockGetSalesmenUseCase()
    var mockSearch = MockSearchSalesmenUseCase()
    var viewModel: SalesmanViewModel!
    
    init() {
        viewModel = SalesmanViewModel(
            getSalesmenUseCase: mockGet,
            searchSalesmenUseCase: mockSearch
        )
    }
    
    @Test("fetchSalesmen success")
    func fetchSalesmenSuccess() async throws {
        // given
        let expected = [Salesman(id: UUID(), name: "John", areas: ["1010"])]
        mockGet.result = .success(expected)
        
        // when
        viewModel.processIntent(.fetchSalesmen)
        try await Task.sleep(nanoseconds: 200_000_000)
        
        // then
        if case .success(let salesmen) = viewModel.state.loadingState {
            #expect(salesmen.map(\.name) == expected.map(\.name))
        } else {
            Issue.record("Expected success state")
        }
    }
    
    @Test("fetchSalesmen failure")
    func fetchSalesmenFailure() async throws {
        mockGet.result = .failure(.salesmenNotFound)
        
        viewModel.processIntent(.fetchSalesmen)
        try await Task.sleep(nanoseconds: 200_000_000)
        
        if case .error(let message) = viewModel.state.loadingState {
            #expect(message == "Salesmen not found")
        } else {
            Issue.record("Expected error state")
        }
    }
    
    @Test("searchSalesmen filters correctly")
    func searchSalesmenFilters() async throws {
        let all = [
            Salesman(id: UUID(), name: "John", areas: ["1010"]),
            Salesman(id: UUID(), name: "Bob", areas: ["2020"])
        ]
        viewModel.state.allSalesmen = all
        mockSearch.filtered = [all[1]]
        
        viewModel.processIntent(.search(postcode: "2020"))
        try await Task.sleep(nanoseconds: 1_200_000_000) // wait > 1s
        
        if case .success(let salesmen) = viewModel.state.loadingState {
            #expect(salesmen.count == 1)
            #expect(salesmen.first?.name == "Bob")
        } else {
            Issue.record("Expected filtered salesmen in success state")
        }
    }
    
    @Test("toggleExpand expands and collapses")
    func toggleExpand() async throws {
        let salesman = Salesman(id: UUID(), name: "John", areas: [])
        
        viewModel.processIntent(.toggleExpand(salesman: salesman))
        #expect(viewModel.state.expandedSalesmenIds.contains(salesman.id))
        
        viewModel.processIntent(.toggleExpand(salesman: salesman))
        #expect(!viewModel.state.expandedSalesmenIds.contains(salesman.id))
    }
}

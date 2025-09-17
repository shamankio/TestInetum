//
//  SalesmanViewModel.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Combine
import Foundation

@MainActor
class SalesmanViewModel: ObservableObject {
    @Published var state: AppState = AppState()

    private let getSalesmenUseCase: GetSalesmenUseCase
    private let searchSalesmenUseCase: SearchSalesmenUseCase
    private var searchTask: Task<Void, Never>?

    init(
        getSalesmenUseCase: GetSalesmenUseCase,
        searchSalesmenUseCase: SearchSalesmenUseCase
    ) {
        self.getSalesmenUseCase = getSalesmenUseCase
        self.searchSalesmenUseCase = searchSalesmenUseCase
    }
    func processIntent(_ intent: SalesmanIntent) {
        switch intent {
        case .fetchSalesmen:
            loadSalesmen()
        case .search(let postcode):
            searchSalesmen(query: postcode)
        case .toggleExpand(let salesman):
            toggleExpand(for: salesman)
        }
    }

    //we also can use Combine in this case
    private func searchSalesmen(query: String) {
        state.searchQuery = query
        // Cancel previous search task
        searchTask?.cancel()

        searchTask = Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second

            if !Task.isCancelled {
                let filtered = searchSalesmenUseCase.execute(
                    postcode: query,
                    salesmen: state.allSalesmen
                )
                state.loadingState = .success(salesmen: filtered)
            }
        }
    }

    private func loadSalesmen() {
        state.loadingState = .loading
        Task {
            let salesmen = try await getSalesmenUseCase.execute()
            switch salesmen {
            case .success(let salesmen):
                state.allSalesmen = salesmen
                state.loadingState = .success(salesmen: salesmen)
            case .failure(let error):
                state.loadingState =
                    .error(error: mapDomainErrorToMessage(error))
            }
        }
    }

    private func toggleExpand(for salesman: Salesman) {
        let id = salesman.id
        if state.expandedSalesmenIds.contains(id) {
            state.expandedSalesmenIds.remove(id)
        } else {
            state.expandedSalesmenIds.insert(id)
        }
    }

    private func mapDomainErrorToMessage(_ error: DomainError) -> String {
        switch error {
        case .invalidPostcode: return "Something went wrong"
        case .salesmenNotFound: return "Salesmen not found"
        case .networkError(_): return "Network error"
        }
    }
}
enum SalesmanIntent {
    case fetchSalesmen
    case search(postcode: String)
    case toggleExpand(salesman: Salesman)
}
struct AppState: Equatable {
    var allSalesmen: [Salesman] = []
    var searchQuery: String = ""
    var expandedSalesmenIds: Set<UUID> = []
    var loadingState: LoadingState = .loading
}
enum LoadingState: Equatable {
    case success(salesmen: [Salesman])
    case loading
    case error(error: String)
}

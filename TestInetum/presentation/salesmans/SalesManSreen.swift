//
//  SalesManSreen.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import SwiftUI

struct SalesManSreen: View {
    @StateObject private var viewModel: SalesmanViewModel
        
        public init(viewModel: SalesmanViewModel) {
            self._viewModel = StateObject(wrappedValue: viewModel)
        }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBarView(
                    searchTerm: $viewModel.state.searchQuery,
                    onSearchTextChanged: {
                        viewModel.processIntent(.search(postcode: $0))
                    }
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 24)

                switch viewModel.state.loadingState {
                    case .success(let salesmen):
                        SalesmanList(
                            salesmanList: salesmen,
                            isExpanded: {viewModel.state.expandedSalesmenIds.contains($0.id)},
                            onToggle: {
                                viewModel.processIntent(.toggleExpand(salesman: $0))
                            }
                        )
                    case .loading:
                        LoadingView().frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .error(let error):
                        ErrorView(message: error) { viewModel.processIntent(.fetchSalesmen) }
                                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .task {
                viewModel.processIntent(.fetchSalesmen)
            }
            .navigationTitle("Adressen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                          ToolbarItem(placement: .navigationBarLeading) {
                              Button("", systemImage: "chevron.left") {
                                  
                              }
                          }
                      }
            .toolbarBackground(Color.accentColor, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    SalesManSreen(
        viewModel:SalesmanViewModel(
            getSalesmenUseCase:  GetSalesmenUseCaseImplement(
                repository:  SalesmanRepositoryImplement(api: FakeSalesmanAPI())),
            searchSalesmenUseCase:  SearchSalesmenUseCaseImplement()
        )
    )
}

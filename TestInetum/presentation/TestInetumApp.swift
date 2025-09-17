//
//  TestInetumApp.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 16.09.2025.
//

import SwiftUI

@main
struct TestInetumApp: App {
    var body: some Scene {
        let dataSource = FakeSalesmanAPI()
               let repository = SalesmanRepositoryImplement(api: dataSource)
               let getSalesmenUseCase = GetSalesmenUseCaseImplement(repository: repository)
               let searchSalesmenUseCase = SearchSalesmenUseCaseImplement()
               let viweModel = SalesmanViewModel(
            getSalesmenUseCase: getSalesmenUseCase,
            searchSalesmenUseCase: searchSalesmenUseCase
        )

        WindowGroup {
            SalesManSreen(viewModel: viweModel)
        }
    }
}

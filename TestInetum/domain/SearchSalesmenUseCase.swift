//
//  SearchSalesmenUseCase.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

protocol SearchSalesmenUseCase {
    func execute(postcode: String, salesmen: [Salesman]) -> [Salesman]
}

class SearchSalesmenUseCaseImplement: SearchSalesmenUseCase {
    func execute(postcode: String, salesmen: [Salesman]) -> [Salesman] {
        guard !postcode.isEmpty else { return salesmen }
        
        return salesmen.filter { salesman in
            salesman.areas.contains { area in
                PostcodeExpression(area).canHandle(searchQuery: postcode)
            }
        }
    }
}

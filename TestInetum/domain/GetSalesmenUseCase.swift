//
//  GetSalesmenUseCaseProtocol.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

protocol GetSalesmenUseCase {
    func execute() async throws -> Result<[Salesman], DomainError>
}

 class GetSalesmenUseCaseImplement: GetSalesmenUseCase {
    private let repository: SalesmanRepository
    
     init(repository: SalesmanRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[Salesman], DomainError> {
        return  await repository.getAllSalesmen()
    }
}

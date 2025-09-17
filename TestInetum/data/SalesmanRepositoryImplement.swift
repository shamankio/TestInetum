//
//  SalesmanRepositoryImplement.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation
class SalesmanRepositoryImplement: SalesmanRepository{
    let api: SalesmanAPI
    init(api: SalesmanAPI){
        self.api = api
    }
    
    func getAllSalesmen() async -> Result<[Salesman], DomainError> {
        do{
            let salemansDTOList = try await api.fetchSalesmenData()
            return .success(
                salemansDTOList.map { salesmanDTO in
                    salesmanDTO.toDomain()
                }
            )
        } catch {
            return .failure(.salesmenNotFound)
        }
    }
}

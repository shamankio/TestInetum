//
//  UserRepository.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

protocol SalesmanRepository {
    func getAllSalesmen() async -> Result<[Salesman], DomainError>
}

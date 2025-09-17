//
//  UserAPI.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

protocol SalesmanAPI {
    func fetchSalesmenData() async throws -> [SalesmanDTO]
}
class FakeSalesmanAPI:SalesmanAPI {
    func fetchSalesmenData() async throws -> [SalesmanDTO] {
        return   [
            SalesmanDTO(name: "Artem Titarenko", areas: ["76133"]),
            SalesmanDTO(name: "Bernd Schmitt", areas: ["7619*"]),
            SalesmanDTO(name: "Chris Krapp", areas: ["762*"]),
            SalesmanDTO(name: "Alex Uber", areas: ["86*"])
        ]
    }
}

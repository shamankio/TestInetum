//
//  SalesmanDTO.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

struct SalesmanDTO: Codable {
    let name: String
    let areas: [String]
    
    func toDomain() -> Salesman {
        return Salesman(name: name, areas: areas)
    }
}

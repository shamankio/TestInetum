//
//  Salesman.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import Foundation

struct Salesman: Identifiable, Equatable {
    var id = UUID()
    let name: String
    let areas: [String]
}

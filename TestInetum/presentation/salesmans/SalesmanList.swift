//
//  SwiftUIView.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import SwiftUI

struct SalesmanList: View {
    let salesmanList: [Salesman]
    let isExpanded: (Salesman) -> Bool
    let onToggle: (Salesman) -> Void
    var body: some View {
        List {
            ForEach(salesmanList) { salesman in
                SalesmanRowView(
                    salesman: salesman,
                    isExpanded: isExpanded(salesman)
                ) { onToggle(salesman) }
                .listRowSeparator(.visible, edges: .bottom)
                .alignmentGuide(.listRowSeparatorLeading) {
                    $0[.leading]
                }
                .alignmentGuide(.listRowSeparatorTrailing) {
                    $0[.trailing]
                }
                .listRowInsets(
                    .init(top: 8, leading: 16, bottom: 0, trailing: 0)
                )
                .accessibilityIdentifier("item.\(salesman.name)")
            }
        }
        .listStyle(.inset)
    }
}

#Preview {
    let salesmanList = [
        Salesman(name: "Artem Titarenko", areas: ["76133"]),
        Salesman(name: "Bernd Schmitt", areas: ["7619*"]),
        Salesman(name: "Chris Krapp", areas: ["762*"]),
        Salesman(name: "Alex Uber", areas: ["86*"]),
    ]
    SalesmanList(
        salesmanList: salesmanList,
        isExpanded: { Salesman in
            false
        }
    ) { salesman in }
}

//
//  SalesmanRowView.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import SwiftUI

struct SalesmanRowView: View {
    let salesman: Salesman
    let isExpanded: Bool
    let onToggleExpansion: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Circle().stroke(Color.divider, lineWidth: 1)
                    .fill(Color.iconBackground)
                    .frame(width: 42, height: 42)

                    .overlay(
                        Text(String(salesman.name.prefix(1)))
                            .foregroundColor(.black)
                            .font(.title2)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(salesman.name)
                        .font(.headline)

                    if isExpanded {
                        HStack {
                            Text(salesman.areas.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(Color.colorGray400)
                        }
                    }
                }

                Spacer()

                Button(action: onToggleExpansion) {
                    Image(
                        systemName: isExpanded
                            ? "chevron.down" : "chevron.right"
                    )
                    .foregroundColor(Color.colorGray400)
                    .imageScale(.small)
                }.padding(.trailing, 16)
            }
            .padding(.vertical, 8)
        }.frame(width: .infinity, height: 68)
    }
}

#Preview("normal") {
    SalesmanRowView(
        salesman: Salesman(name: "Artem Anderson", areas: ["76133"]),
        isExpanded: false,
        onToggleExpansion: {
        }
    )
    .padding()
}
#Preview("expanded") {
    SalesmanRowView(
        salesman: Salesman(name: "Artem Anderson", areas: ["76133", "76132"]),
        isExpanded: true,
        onToggleExpansion: {
        }
    )
    .padding()
}

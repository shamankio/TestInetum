//
//  LoadingView.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(2)

            Text("Loading...")
                .font(.headline)
                .foregroundColor(.secondary)
        }.accessibilityIdentifier("LoadingView")
    }
}

#Preview {
    LoadingView()
}

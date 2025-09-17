//
//  ErrorView.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Error")
                .font(.headline)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button("Retry", action: onRetry)
                .buttonStyle(.borderedProminent)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ErrorView(message: "Errror message", onRetry: {})
}

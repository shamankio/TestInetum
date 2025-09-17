//
//  SearchBarView.swift
//  TestInetum
//
//  Created by Oleksandr Rustanovych on 17.09.2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchTerm: String
    let onSearchTextChanged: (String) -> Void
    var body: some View {
               HStack {
                   Image(systemName: "magnifyingglass")
                       .foregroundColor(Color("ColorGray400"))
                   
                   TextField("Suche", text: $searchTerm)
                       .font(.system(size: 17))
                       .onChange(of: searchTerm) { oldValue, newValue in
                           onSearchTextChanged(newValue)
                       }
                   if searchTerm.isEmpty {
                       Image(systemName: "magnifyingglass")
                           .foregroundColor(Color("ColorGray400"))
                   }else {
                       Button {
                           searchTerm = ""
                       } label: {
                           Image(systemName:"multiply.circle.fill")
                       }
                       .foregroundColor(Color("ColorGray400"))
                   }
                  
               }
               .padding(8)
               .background(Color("SearchBackgroundColor"))
               .cornerRadius(10)
               .accessibilityIdentifier("searchView")
    }
}

#Preview {
    SearchBarView(searchTerm:.constant("") , onSearchTextChanged: {_ in })
        .padding()
}
#Preview("with text") {
    SearchBarView(searchTerm:.constant("my search") , onSearchTextChanged: {_ in })
        .padding()
}

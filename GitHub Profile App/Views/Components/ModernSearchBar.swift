//
//  SearchBar.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(text.isEmpty ? ThemeColors.textSecondary : ThemeColors.primary)
                    .font(.system(size: 18))
                    .padding(.leading, 8)
                
                TextField("GitHub Username", text: $text)
                    .padding(.vertical, 12)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(ThemeColors.textSecondary)
                            .padding(.trailing, 8)
                    }
                }
            }
            .padding(.horizontal, 8)
            .background(ThemeColors.card)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            Button(action: onSearch) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(ThemeColors.primary)
                    .padding(.leading, 8)
            }
            .disabled(text.isEmpty)
            .opacity(text.isEmpty ? 0.5 : 1.0)
        }
        .padding(.horizontal)
    }
}

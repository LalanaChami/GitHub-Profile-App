//
//  CardView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//
import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    var padding: CGFloat = 16
    var cornerRadius: CGFloat = 16
    
    init(padding: CGFloat = 16, cornerRadius: CGFloat = 16, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.padding = padding
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(ThemeColors.card)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

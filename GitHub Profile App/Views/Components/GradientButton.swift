//
//  GradientButton.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//
import SwiftUI

struct GradientButton: View {
    var text: String
    var icon: String? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [ThemeColors.primary, ThemeColors.primary.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .shadow(color: ThemeColors.primary.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }
}

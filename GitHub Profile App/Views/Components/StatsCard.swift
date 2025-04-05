//
//  StatsCard.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//
import SwiftUI

struct StatsCard: View {
    let title: String
    let value: Int
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(ThemeColors.primary)
                
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(ThemeColors.textSecondary)
            }
            
            Text("\(value)")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(ThemeColors.text)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(ThemeColors.card)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

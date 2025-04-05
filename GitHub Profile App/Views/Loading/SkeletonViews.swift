//
//  SkeletonViews.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import SwiftUI


struct SkeletonView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.1), Color.gray.opacity(0.2)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(8)
            .mask(Rectangle().cornerRadius(8))
            .offset(x: isAnimating ? 400 : -400)
            .animation(
                Animation.linear(duration: 1.5)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

// MARK: - UserProfileSkeletonView
struct UserProfileSkeletonView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 120)
                .overlay(SkeletonView())
                .padding(.top, 20)
            
            SkeletonView()
                .frame(width: 200, height: 30)
            
            SkeletonView()
                .frame(width: 150, height: 20)
                .padding(.bottom, 10)
            
            SkeletonView()
                .frame(height: 60)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                VStack {
                    SkeletonView()
                        .frame(width: 50, height: 30)
                    
                    SkeletonView()
                        .frame(width: 80, height: 20)
                }
                
                VStack {
                    SkeletonView()
                        .frame(width: 50, height: 30)
                    
                    SkeletonView()
                        .frame(width: 80, height: 20)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

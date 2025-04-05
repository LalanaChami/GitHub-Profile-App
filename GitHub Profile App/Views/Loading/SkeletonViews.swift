//
//  SkeletonViews.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import SwiftUI


struct SkeletonView: View {
    @State private var animationOffset: CGFloat = -200
    let isCircle: Bool
    var body: some View {
        GeometryReader { geometry in
            Color.gray.opacity(0.2)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.6), Color.clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .rotationEffect(.degrees(70))
                    .offset(x: animationOffset)
                    .frame(width: geometry.size.width * 2)
                )
                .mask(
                    isCircle
                    ? AnyView(Circle().aspectRatio(isCircle ? 1 : nil, contentMode: .fit))
                    : AnyView(Rectangle().cornerRadius(8))
                )
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        animationOffset = geometry.size.width + 200
                    }
                }
        }
        .cornerRadius(8)
    }
}

// MARK: - UserProfileSkeletonView
struct UserProfileSkeletonView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 120)
                .overlay(SkeletonView(isCircle: true))
            
            SkeletonView(isCircle: false)
                .frame(width: 200, height: 30)
            
            SkeletonView(isCircle: false)
                .frame(width: 150, height: 20)
                .padding(.bottom, 10)
            
            SkeletonView(isCircle: false)
                .frame(height: 60)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                VStack {
                    SkeletonView(isCircle: false)
                        .frame(width: 50, height: 30)
                    
                    SkeletonView(isCircle: false)
                        .frame(width: 80, height: 20)
                }
                
                VStack {
                    SkeletonView(isCircle: false)
                        .frame(width: 50, height: 30)
                    
                    SkeletonView(isCircle: false)
                        .frame(width: 80, height: 20)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

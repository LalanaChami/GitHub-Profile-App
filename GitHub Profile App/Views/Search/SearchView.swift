//
//  SearchView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-04.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var username: String = ""
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            AnimatedBackground()
            
            VStack(spacing: 20) {
            
                SearchBar(text: $username, onSearch: {
                    viewModel.searchUser(username: username)
                })
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -10)
                .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: isAnimating)
                
                ZStack {
                    if viewModel.isLoading {
                        VStack {
                            ProgressView()
                                .scaleEffect(1.5)
                                .padding()
                            
                            Text("Searching...")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(ThemeColors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else if let user = viewModel.user {
                        NavigationLink(destination: UserProfileView(user: user)) {
                            UserProfilePreview(user: user)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else if viewModel.showNotFoundError {
                        NotFoundView()
                    } else {
                        EmptyStateView()
                    }
                }
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeIn.delay(0.3), value: isAnimating)
                
                Spacer()
            }
            .padding(.top)
        }
        .onAppear {
            withAnimation {
                isAnimating = true
            }
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(ThemeColors.primary.opacity(0.7))
                .padding()
            
            Text("Search for GitHub Users")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(ThemeColors.text)
            
            Text("Enter a GitHub username to view the user profile")
                .font(.system(size: 16))
                .foregroundColor(ThemeColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(40)
        .background(ThemeColors.card)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

struct NotFoundView: View {
    @State private var isAnimating = false
    
    var body: some View {
        CardView {
            VStack(spacing: 20) {
                Image(systemName: "person.slash.fill")
                    .font(.system(size: 60))
                    .foregroundColor(ThemeColors.error)
                    .padding()
                    .rotationEffect(.degrees(isAnimating ? 5 : -5))
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                
                Text("User Not Found")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(ThemeColors.text)
                
                Text("The GitHub user you're looking for doesn't exist or couldn't be found.")
                    .font(.system(size: 16))
                    .foregroundColor(ThemeColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding(20)
        }
        .padding(.horizontal, 20)
        .onAppear {
            isAnimating = true
        }
    }
}

struct UserProfilePreview: View {
    let user: User
    @State private var isHovered = false
    
    var body: some View {
        CardView {
            HStack(spacing: 16) {
                AvatarView(url: user.avatarUrl, size: 60)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name ?? user.login)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(ThemeColors.text)
                    
                    Text("@\(user.login)")
                        .font(.system(size: 14))
                        .foregroundColor(ThemeColors.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(ThemeColors.primary)
                    .padding(8)
                    .background(ThemeColors.primary.opacity(0.1))
                    .clipShape(Circle())
                    .scaleEffect(isHovered ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3), value: isHovered)
            }
        }
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .shadow(color: isHovered ? ThemeColors.primary.opacity(0.2) : Color.black.opacity(0.05),
                radius: isHovered ? 15 : 10,
                x: 0,
                y: isHovered ? 10 : 5)
        .animation(.spring(response: 0.3), value: isHovered)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}


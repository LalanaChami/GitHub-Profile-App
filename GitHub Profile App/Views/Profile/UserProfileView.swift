//
//  UserProfileView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import SwiftUI

struct UserProfileView: View {
    @State var user: User
    let isSeachedUser: Bool
    @StateObject private var followersViewModel = FollowersViewModel()
    @StateObject private var followingViewModel = FollowingViewModel()
    @ObservedObject private var searchViewModel =  SearchViewModel()
    @State private var isLoading = true
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            AnimatedBackground()
            
            ScrollView {
                if isLoading {
                    UserProfileSkeletonView()
                        .onAppear {

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                if isSeachedUser {
                                    isLoading = false
                                }
                            }
                        }
                } else {
                    VStack(alignment: .center, spacing: 24) {
                        AvatarView(url: user.avatarUrl, size: 140)
                            .padding(.top, 30)
                            .scaleEffect(isAnimating ? 1.0 : 0.8)
                            .opacity(isAnimating ? 1.0 : 0)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1), value: isAnimating)
                        
                        VStack(spacing: 8) {
                            Text(user.name ?? "")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(ThemeColors.text)
                            
                            Text("@\(user.login)")
                                .font(.system(size: 18))
                                .foregroundColor(ThemeColors.textSecondary)
                        }
                        .opacity(isAnimating ? 1.0 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: isAnimating)
                        
                        if let bio = user.bio, !bio.isEmpty {
                            CardView(padding: 16, cornerRadius: 12) {
                                VStack(spacing: 8) {
                                    HStack {
                                        Image(systemName: "quote.bubble")
                                            .foregroundColor(ThemeColors.primary)
                                        Text("Bio")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(ThemeColors.primary)
                                        Spacer()
                                    }
                                    
                                    Text(bio)
                                        .font(.system(size: 16))
                                        .foregroundColor(ThemeColors.text)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(.horizontal)
                            .opacity(isAnimating ? 1.0 : 0)
                            .offset(y: isAnimating ? 0 : 20)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.3), value: isAnimating)
                        }
                        
                        HStack(spacing: 16) {
                            NavigationLink(destination: FollowersView(username: user.login, viewModel: followersViewModel)) {
                                StatsCard(
                                    title: "Followers",
                                    value: user.followers ?? 0,
                                    icon: "person.2"
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: FollowingView(username: user.login, viewModel: followingViewModel)) {
                                StatsCard(
                                    title: "Following",
                                    value: user.following ?? 0,
                                    icon: "person.badge.plus"
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                        .opacity(isAnimating ? 1.0 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.4), value: isAnimating)
                        
                        Link(destination: URL(string: user.htmlUrl)!) {
                            HStack {
                                Image(systemName: "link")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("View on GitHub")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 30)
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
                        .padding(.top, 10)
                        .opacity(isAnimating ? 1.0 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5), value: isAnimating)
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(user.login)
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            isLoading = true
            isAnimating = false
            searchViewModel.searchUser(username: user.login)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    isAnimating = true
                }
            }
        }
        .onAppear {
            if !isSeachedUser {
                isLoading = true
                searchViewModel.searchUser(username: user.login)
            }
            withAnimation {
                isAnimating = true
            }
        }
        .onReceive(searchViewModel.$user) { userData in
            if let userData = userData {
                user = userData
                isLoading = false
            }
        }
    }
}

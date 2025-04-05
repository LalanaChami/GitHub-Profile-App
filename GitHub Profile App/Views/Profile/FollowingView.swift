//
//  FollowingView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//


import SwiftUI

struct FollowingView: View {
    let username: String
    @ObservedObject var viewModel: FollowingViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.orange)
                        .padding()
                    
                    Text("Error")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(errorMessage)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else if viewModel.following.isEmpty {
                VStack {
                    Image(systemName: "person.2.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("Not Following Anyone")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("This user isn't following anyone yet.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else {
                List(viewModel.following) { user in
                    NavigationLink(destination: UserProfileView(user: user, isSeachedUser: false)) {
                        UserListItemView(user: user)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    viewModel.fetchFollowing(for: username)
                }
            }
        }
        .navigationTitle("Following")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel.following.isEmpty {
                viewModel.fetchFollowing(for: username)
            }
        }
    }
}

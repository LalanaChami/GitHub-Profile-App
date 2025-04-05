//
//  FollowersView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import SwiftUI

struct FollowersView: View {
    let username: String
    @ObservedObject var viewModel: FollowersViewModel
    
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
            } else if viewModel.followers.isEmpty {
                VStack {
                    Image(systemName: "person.2.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("No Followers")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("This user doesn't have any followers yet.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else {
                List(viewModel.followers) { user in
                    NavigationLink(destination: UserProfileView(user: user, isSeachedUser: false)) {
                        UserListItemView(user: user)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    viewModel.fetchFollowers(for: username)
                }
            }
        }
        .navigationTitle("Followers")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel.followers.isEmpty {
                viewModel.fetchFollowers(for: username)
            }
        }
    }
}

struct UserListItemView: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.login)
                    .font(.headline)
                
                if let name = user.name {
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

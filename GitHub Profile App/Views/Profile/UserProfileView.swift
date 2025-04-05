//
//  UserProfileView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            if isLoading {
                UserProfileSkeletonView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isLoading = false
                        }
                    }
            } else {
                VStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: URL(string: user.avatarUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .padding(.top, 20)
                    
                    VStack(spacing: 4) {
                        Text(user.name ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("@\(user.login)")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    if let bio = user.bio, !bio.isEmpty {
                        Text(bio)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    HStack(spacing: 40) {
                        VStack {
                            Text("\(user.followers)")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text("Followers")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        VStack {
                            Text("\(user.following)")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text("Following")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    Link(destination: URL(string: user.htmlUrl)!) {
                        HStack {
                            Image(systemName: "link")
                            Text("View on GitHub")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(user.login)
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isLoading = false
            }
        }
    }
}

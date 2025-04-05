//
//  SearchView.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-04.
//

import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("GitHub Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button(action: {
                    //
                }) {
                    Text("Search")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Text("User Found")
            
            AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/33516757?s=400&u=1d98560f634b4901a75dd956814143dd0c0a7d19")!)
            Spacer()
        }
    }
}

struct NotFoundView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .padding()
            
            Text("User Not Found")
                .font(.title)
                .fontWeight(.bold)
            
            Text("The GitHub user you're looking for doesn't exist or couldn't be found.")
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

struct UserProfilePreview: View {
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
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name ?? user.login)
                    .font(.headline)
                
                Text("@\(user.login)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

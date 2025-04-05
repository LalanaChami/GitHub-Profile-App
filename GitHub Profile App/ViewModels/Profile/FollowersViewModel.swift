//
//  FollowersViewModel.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-05.
//

import Foundation
import Combine

class FollowersViewModel: ObservableObject {
    @Published var followers: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let githubService = GitHubService()
    
    func fetchFollowers(for username: String) {
        isLoading = true
        errorMessage = nil
        
        githubService.fetchFollowers(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] followers in
                self?.followers = followers
            })
            .store(in: &cancellables)
    }
}



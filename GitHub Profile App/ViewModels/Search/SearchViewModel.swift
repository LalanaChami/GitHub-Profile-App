//
//  SearchViewModel.swift
//  GitHub Profile App
//
//  Created by Lalana Thanthirigama on 2025-04-04.
//
import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var showNotFoundError = false
    
    private var cancellables = Set<AnyCancellable>()
    private let githubService = GitHubService()
    
    func searchUser(username: String) {
        guard !username.isEmpty else { return }
        
        isLoading = true
        showNotFoundError = false
        user = nil
        
        githubService.invalidateCache(for: username)
        
        githubService.fetchUser(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case .failure = completion {
                    self?.showNotFoundError = true
                }
            }, receiveValue: { [weak self] user in
                self?.user = user
            })
            .store(in: &cancellables)
    }
}

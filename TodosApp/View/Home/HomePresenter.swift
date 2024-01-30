//
//  HomePresenter.swift
//  TodosApp
//
//  Created by Kevin Jonathan on 30/01/24.
//

import SwiftUI

class HomePresenter: ObservableObject {
    @Published var todos: [Todo]?
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    var filteredTodos: [Todo]? {
        get {
            guard let todos = self.todos else { return nil }
            guard searchText != "" else { return self.todos }
            
            return todos.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchData() {
        networkService.fetchData { [weak self] (todos, errorMessage) in
            DispatchQueue.main.async {
                if let todos = todos {
                    self?.todos = todos
                } else if let errorMessage = errorMessage {
                    self?.errorMessage = errorMessage
                }
            }
        }
    }
}

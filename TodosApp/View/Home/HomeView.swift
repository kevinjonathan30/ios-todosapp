//
//  HomeView.swift
//  TodosApp
//
//  Created by Kevin Jonathan on 30/01/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    init() {
        presenter = HomePresenter(networkService: NetworkService())
    }
    
    var body: some View {
        VStack {
            // Display your todos or error message based on presenter's state
            if presenter.filteredTodos == nil {
                VStack {
                    ProgressView()
                    Text("Loading..")
                }
            } else if let error = presenter.errorMessage {
                Text("Error: \(error)")
            } else if let todos = presenter.filteredTodos, !todos.isEmpty {
                List(todos, id: \.id) { todo in
                    HStack {
                        Text(todo.title)
                        Spacer()
                        
                        if todo.completed {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            } else {
                Text("No Todos")
            }
        }
        .navigationTitle("Todos")
        .onAppear {
            self.presenter.fetchData()
        }
        .refreshable {
            self.presenter.fetchData()
        }
        .searchable(text: $presenter.searchText)
    }
}

#Preview {
    HomeView()
}

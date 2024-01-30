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
            switch presenter.viewState {
            case .loading:
                loadingView
            case .empty:
                emptyView
            case .loaded:
                loadedView
            case .error(let error):
                errorView(error: error)
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

// MARK: ViewBuilder

private extension HomeView {
    @ViewBuilder 
    var loadingView: some View {
        VStack {
            ProgressView()
            Text("Loading..")
        }
    }
    
    @ViewBuilder 
    var emptyView: some View {
        Text("No Todos")
    }
    
    @ViewBuilder 
    var loadedView: some View {
        List(presenter.filteredTodos ?? [], id: \.id) { todo in
            todoItem(todo: todo)
        }
    }
    
    @ViewBuilder
    func errorView(error: String) -> some View {
        Text(error)
    }
    
    @ViewBuilder
    func todoItem(todo: Todo) -> some View {
        HStack {
            Text(todo.title)
            Spacer()
            
            if todo.completed {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    HomeView()
}

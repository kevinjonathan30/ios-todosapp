//
//  NetworkService.swift
//  TodosApp
//
//  Created by Kevin Jonathan on 30/01/24.
//

import Foundation

class NetworkService {
    
    /// A function to fetch data from the API
    /// - Parameter completion: Returns the data and the error respectively
    func fetchData(completion: @escaping ([Todo]?, String?) -> Void) {
        // URL for fetching todos for user with ID 1
        let urlString = "https://jsonplaceholder.typicode.com/todos?userId=1"
        
        // Create URL object
        if let url = URL(string: urlString) {
            
            // Create URLSession
            let session = URLSession.shared
            
            // Create data task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                // Check for errors
                if let error = error {
                    let errorMessage = "Error: \(error.localizedDescription)"
                    print(errorMessage)
                    completion([], errorMessage)
                    return
                }
                
                // Check if data is available
                guard let data = data else {
                    let errorMessage = "No data received"
                    print(errorMessage)
                    completion([], errorMessage)
                    return
                }
                
                do {
                    // Decode JSON data into an array of Todo objects
                    let todos = try JSONDecoder().decode([Todo].self, from: data)
                    completion(todos, nil)
                } catch {
                    let errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                    print(errorMessage)
                    completion([], errorMessage)
                }
            }
            
            // Resume the task to start the network request
            task.resume()
        } else {
            let errorMessage = "Invalid URL"
            print(errorMessage)
            completion([], errorMessage)
        }
    }
}


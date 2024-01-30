//
//  Todo.swift
//  TodosApp
//
//  Created by Kevin Jonathan on 30/01/24.
//

import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

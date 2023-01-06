//
//  TaskModel.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 06/01/23.
//

import SwiftUI
struct Task: Identifiable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
    
}
///- sample of date
var sampleTasks:[Task] = [
    .init(dateAdded: Date(timeIntervalSince1970: 1672829809), taskName: "hjhbjvd", taskDescription: "", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "hjhbjvd", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1672833709), taskName: "hjhbjvd", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1672851409), taskName: "hjhbjvd", taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: 1672833709), taskName: "hjhbjvd", taskDescription: "", taskCategory: .general),
]


enum Category: String, CaseIterable{
    case general = "General"
    case bug = "Bug"
    case idea = "Idea"
    
    var color: Color{
        switch self{
        case .general:
            return Color.purple
        case .bug:
            return Color.green
        case .idea:
            return Color.pink
        }
    }
}

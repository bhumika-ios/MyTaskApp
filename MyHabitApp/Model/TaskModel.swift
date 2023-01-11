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
/// sample task dates are set between january 4 and 5 , so while building, change it to the most recent date otherwise it wont show up on the screen
var sampleTasks:[Task] = [
    .init(dateAdded: Date(timeIntervalSince1970: 1673417618), taskName: "hjhbjvd", taskDescription: "", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1673417652), taskName: "hjhbjvd", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1673417662), taskName: "hjhbjvd", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1673417678), taskName: "hjhbjvd", taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: 1673417609), taskName: "hjhbjvd", taskDescription: "", taskCategory: .general),
]

///- category Enum with color
///add your category type here with a color
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

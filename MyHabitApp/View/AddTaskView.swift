//
//  AddTaskView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 11/01/23.
//

import SwiftUI

struct AddTaskView: View {
    // calplback
    var onAdd: (Task)->()
    //view properties
    @Environment(\.dismiss) private var dismiss
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskCategory: Category = .general
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10){
                
            }
            .hAlign(.leading)
            .padding(15)
            .background{
                taskCategory.color
                    .ignoresSafeArea()
            }
        }
        .vAlign(.top)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView{task in
            
        }
    }
}

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
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }
                Text("Create New Task")
                    .laila(28, .light)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
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
    @ViewBuilder
    func TitleView(_ value: String)->some View{
        Text(value)
            .laila(12, .regular)
            .foregroundColor(.white.opacity(0.7))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView{task in
            
        }
    }
}

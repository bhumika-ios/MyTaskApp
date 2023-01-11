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
                
                TitleView("Name")
                
                TextField("Make New Name", text: $taskName)
                    .laila(16, .regular)
                    .tint(.white)
                    .padding(.top,2)
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                TitleView("DATE")
                    .padding(.top,15)
                HStack(alignment: .bottom, spacing: 12){
                    HStack(spacing: 12){
                        Text(taskDate.toString("EEEE dd, MMMM"))
                            .laila(16, .regular)
                        
                        ///- custom calender
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate, displayedComponents: [.date])
                                //why not set opacity to zero? becoz when we set opacity to zero, it will hide the view and not allow us to tap on it, but blend mode doesnt hide the view
                                    .blendMode(.destinationOver)
                            }
                        
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 0.7)
                            .offset(y: 5)
                    }
                    HStack(spacing: 12){
                        Text(taskDate.toString("hh:mm a"))
                            .laila(16, .regular)
                        
                        ///- custom calender
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate, displayedComponents: [.hourAndMinute])
                                //why not set opacity to zero? becoz when we set opacity to zero, it will hide the view and not allow us to tap on it, but blend mode doesnt hide the view
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 0.7)
                            .offset(y: 5)
                    }
                }
                .padding(.bottom,15)
            }
            .environment(\.colorScheme, .dark)
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
    func TitleView(_ value: String,_ color: Color = .white.opacity((0.7)) )->some View{
        Text(value)
            .laila(12, .regular)
            .foregroundColor(color)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView{task in
            
        }
    }
}

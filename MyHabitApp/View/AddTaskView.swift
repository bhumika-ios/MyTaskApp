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
    // category animation property
    @State private var animateColor: Color = Category.general.color
    @State private var animate: Bool = false
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
                ZStack{
                    taskCategory.color
                    // so the animation is simple: when the new category is tapped the new color will be popped out the bottom trailing as a scaling effect and after the animation is finished it will be reset to its default state so that the next color will again be popped out in the same way
                    GeometryReader{
                        let size = $0.size
                        Rectangle()
                            .fill(animateColor)
                            .mask{
                                Circle()
                            }
                            .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                    }
                    .clipped()
                }
                    .ignoresSafeArea()
            }
            VStack(alignment: .leading, spacing: 10){
                TitleView("DESCRIPTION", .gray)
                
                TextField("About your Task", text: $taskDescription)
                    .laila(16, .regular)
                    .padding(.top,2)
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .frame(height: 1)
                
                TitleView("CATEGORY", .gray)
                    .padding(.top, 15)
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3),spacing: 15){
                    ForEach(Category.allCases, id: \.rawValue){ category in
                        Text(category.rawValue.uppercased())
                            .laila(12, .regular)
                            .hAlign(.center)
                            .padding(.vertical, 5)
                            .background{
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(category.color.opacity(0.25))
                            }
                            .foregroundColor(category.color)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                //avoids simultaneous taps
                                guard !animate else{return}
                                animateColor = category.color
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)){
                                    animate = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    animate = false
                                    taskCategory = category
                                }
                            }
                    }
                }
                .padding(.top,5)
                Button{
                    
                }label: {
                    Text("Create Task")
                        .laila(16, .regular)
                        .foregroundColor(.white)
                        .padding(.vertical,15)
                        .hAlign(.center)
                        .background{
                            Capsule()
                                .fill(taskCategory.color.gradient)
                        }
                }
                .vAlign(.bottom)
                .disabled(taskName == "")
                .opacity(taskName == "" ? 0.6 : 1)
            }
            .padding(15)
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

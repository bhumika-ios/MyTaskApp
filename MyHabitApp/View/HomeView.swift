//
//  HomeView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 06/01/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false) {
                 
                }
                .safeAreaInset(edge: .top, spacing: 0) {
                    HeaderView()
                    
                }
        AddTaskView1()
            }
        }
        
    }
    
    /// - Header View
    @ViewBuilder
    func HeaderView()->some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 6){
                    Text("Today")
                        .laila(22, .light)
                    
                    Text("Welcome, User")
                        .laila(14, .light)
                }
                .hAlign(.leading)
            }
            // - Today DAte in string
            Text(Date().toString("MMM YYYY"))
                .laila(16, .medium)
                .hAlign(.leading)
                .padding(.top, 15)
            
            ///- Current week Row
            WeekRow()
        }
        .padding(15)
    }
    ///- week Row
    @ViewBuilder
    func WeekRow()->some View{
        HStack(spacing: 0){
            ForEach(Calendar.current.currentWeek){weekDay in
                VStack(spacing: 6){
                    Text(weekDay.string)
                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
// MARK: Add Plus Button View
struct AddTaskView1: View {
  @State var showCreateTaskView = false
    @State private var animate: Bool = false
    private let secondaryAccentColor = Color(.blue)

  var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Button(
          action: {
          //  showCreateTaskView = true
          }, label: {
           Image(systemName: "plus")
                  .resizable()
              .multilineTextAlignment(.center)
              .frame(width: 20, height: 20)
              .foregroundColor(Color.white)
              .padding()
          })
        .background(animate ? Color.purple : Color.blue)
          .cornerRadius(20)
          .padding()
          .padding(.horizontal, animate ? 30 : 30)
          .scaleEffect(animate ? 1.1 : 1.0)
          .offset(y: animate ? -1 : .zero)
//          .sheet(isPresented: $showCreateTaskView) {
//            CreateTaskView()
//          }
      }
      .padding(.bottom)
    }
    .onAppear(perform: addAnimation)
  }
    private func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                self.animate.toggle()
            }
        })
    }
}

// MARK: View Extensions
extension View{
    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: Date Extension
extension Date{
    func toString(_ format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

//MARK: Calendar extension
extension Calendar{
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else{ return []}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString("EEEE") // - EEEE return the weekday symbol (e.g , Monday) from the given date
                let isToday = self.isDateInToday(day)
                // so the logic is to retrive the week first day and with the calendars adding method we are getting the subsequent seven dates from the strat date
                week.append(.init(string: weekDaySymbol, date: day))
            }
        }
        return week
    }
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}


//
//  HomeView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 06/01/23.
//

import SwiftUI

struct HomeView: View {
    /// - View Properties
    @State private var currentDay: Date = .init()
    var body: some View {
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false) {
                 TimelineView()
                        .padding(15)
                }
                .safeAreaInset(edge: .top, spacing: 0) {
                    HeaderView()
                    
                }
      
            }
             AddTaskView1()
        }
        
    }
    /// -  timeline view
    @ViewBuilder
    func TimelineView()->some View{
        VStack{
            let hours = Calendar.current.hours
            ForEach(hours, id: \.self){hour in
                TimelineViewRow(hour)
            }
        }
    }
    /// - timelineview row
    @ViewBuilder
    func TimelineViewRow(_ hour: Date)->some View{
        HStack(alignment: .top){
            Text(hour.toString("h a"))
                .laila(14, .regular)
                .frame(width: 45, alignment: .leading)
            Rectangle()
                .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                .frame(height: 0.5)
        }
        .hAlign(.leading)
        .padding(.vertical,15)
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
        .background{
            
            VStack(spacing: 0){
                Color.white
                ///- Gradient opacity background
                /// give a nice gradient effect at its bottom.
                Rectangle()
                    .fill(.linearGradient(colors: [
                        .white,
                        .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
    }
    ///- week Row
    @ViewBuilder
    func WeekRow()->some View{
        HStack(spacing: 0){
            ForEach(Calendar.current.currentWeek){weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6){
                   // Text(weekDay.string)
                    Text(weekDay.string.prefix(3))
                        .laila(14, .medium)
                    Text(weekDay.date.toString("dd"))
                        .laila(16, status ? .medium : .regular)
                }
                ///- Highlighting the currently active day
                .foregroundColor(status ? Color(.blue) : .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)){
                        currentDay = weekDay.date
                    }
                }
                
            }
        }
        .padding(.vertical,10)
        .padding(.horizontal, -15)
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
    ///- return 24 hours in a day
    /// so when we get the start of the day, which means 0:00 with the help of this we can easily retrive the 24 - hours dates.
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay){
                hours.append(date)
            }
        }
        return hours
    }
    ///- Retuen current week in array format
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


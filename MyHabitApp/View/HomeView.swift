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
        }
        .padding()
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
